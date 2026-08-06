import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifier} from '../types';
import {BorrowUpdate} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';
import {boolPrompt, translateJsBoolToSol} from '../prompts/boolPrompt';
import {percentPrompt, translateJsPercentToSol} from '../prompts/percentPrompt';

export async function fetchBorrowUpdate<T extends boolean>(required?: T) {
  return {
    enabledToBorrow: await boolPrompt({
      message: 'enabled to borrow',
      required,
    }),
    flashloanable: await boolPrompt({
      message: 'flashloanable',
      required,
    }),
    reserveFactor: await percentPrompt({
      message: 'reserve factor',
      required,
    }),
  };
}

type BorrowUpdates = BorrowUpdate[];

function renderBorrowUpdateEntries(market: MarketIdentifier, cfgs: BorrowUpdates, varName: string) {
  return cfgs
    .map(
      (cfg, ix) => `${varName}[${ix}] = IAaveV3ConfigEngine.BorrowUpdate({
               asset: ${translateAssetToAssetLibUnderlying(cfg.asset, market)},
               enabledToBorrow: ${translateJsBoolToSol(cfg.enabledToBorrow)},
               flashloanable: ${translateJsBoolToSol(cfg.flashloanable)},
               reserveFactor: ${translateJsPercentToSol(cfg.reserveFactor)}
             });`,
    )
    .join('\n');
}

function borrowUpdateOverrides(market: MarketIdentifier, cfgs: BorrowUpdates): string[] {
  return [
    `function _expectedBorrowChanges() internal pure override returns (IAaveV3ConfigEngine.BorrowUpdate[] memory) {
      IAaveV3ConfigEngine.BorrowUpdate[] memory borrowUpdates;
      borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](${cfgs.length});

      ${renderBorrowUpdateEntries(market, cfgs, 'borrowUpdates')}
      return borrowUpdates;
    }`,
  ];
}

export const borrowsUpdates: FeatureModule<BorrowUpdates> = {
  value: FEATURE.BORROWS_UPDATE,
  description: 'BorrowsUpdates (enabledToBorrow, flashloanable, reserveFactor)',
  async cli({market}) {
    const assets = await assetsSelectPrompt({
      message: 'Select the assets you want to amend',
      market,
    });
    const response: BorrowUpdates = [];
    for (const asset of assets) {
      console.log(`Fetching information for BorrowUpdates on ${market} ${asset}`);
      response.push({...(await fetchBorrowUpdate(false)), asset});
    }
    return response;
  },
  build({market, cfg}) {
    const response: CodeArtifact = {
      code: {
        fn: [
          `function borrowsUpdates() public pure override returns (IAaveV3ConfigEngine.BorrowUpdate[] memory) {
          IAaveV3ConfigEngine.BorrowUpdate[] memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](${
            cfg.length
          });

          ${renderBorrowUpdateEntries(market, cfg, 'borrowUpdates')}

          return borrowUpdates;
        }`,
        ],
      },
      test: {
        fn: borrowUpdateOverrides(market, cfg),
        updatedAssets: cfg.map((cfg) => translateAssetToAssetLibUnderlying(cfg.asset, market)),
      },
    };
    return response;
  },
};
