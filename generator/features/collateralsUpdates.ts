import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifier} from '../types';
import {getMarketChain} from '../common';
import {CollateralUpdate, CollateralUpdatePartial} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';
import {percentPrompt, translateJsPercentToSol} from '../prompts/percentPrompt';

export async function fetchCollateralUpdate(
  market: MarketIdentifier,
  required?: boolean,
): Promise<CollateralUpdatePartial> {
  return {
    ltv: await percentPrompt({
      message: 'Loan to value',
      required,
    }),
    liqThreshold: await percentPrompt({
      message: 'Liquidation Threshold',
      required,
    }),
    liqBonus: await percentPrompt({
      message: 'Liquidation bonus',
      required,
    }),
    liqProtocolFee: await percentPrompt({
      message: 'Liquidation protocol fee',
      required,
    }),
  };
}

type CollateralUpdates = CollateralUpdate[];

function assertReserveConfigChangeTestsSupported(market: MarketIdentifier) {
  if (getMarketChain(market) !== 'ZkSync') return;
  throw new Error(
    'Reserve config change tests are currently unsupported on ZkSync: the pinned aave-helpers/zksync path references ReserveConfig fields that are not available in the pinned aave-v3-origin-tests dependency.',
  );
}

function renderCollateralUpdates(
  market: MarketIdentifier,
  cfgs: CollateralUpdates,
  varName: string,
) {
  return cfgs
    .map(
      (cfg, ix) => `${varName}[${ix}] = IAaveV3ConfigEngine.CollateralUpdate({
               asset: ${translateAssetToAssetLibUnderlying(cfg.asset, market)},
               ltv: ${translateJsPercentToSol(cfg.ltv)},
               liqThreshold: ${translateJsPercentToSol(cfg.liqThreshold)},
               liqBonus: ${translateJsPercentToSol(cfg.liqBonus)},
               liqProtocolFee: ${translateJsPercentToSol(cfg.liqProtocolFee)}
             });`,
    )
    .join('\n');
}

function collateralUpdateOverrides(market: MarketIdentifier, cfgs: CollateralUpdates): string[] {
  return [
    `function _expectedCollateralChanges() internal pure override returns (IAaveV3ConfigEngine.CollateralUpdate[] memory) {
      IAaveV3ConfigEngine.CollateralUpdate[] memory collateralUpdate;
      collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](${cfgs.length});

      ${renderCollateralUpdates(market, cfgs, 'collateralUpdate')}
      return collateralUpdate;
    }`,
  ];
}

export const collateralsUpdates: FeatureModule<CollateralUpdates> = {
  value: FEATURE.COLLATERALS_UPDATE,
  description: 'CollateralsUpdates (ltv,lt,lb,liqProtocolFee,eModeCategory)',
  async cli({market}) {
    console.log(`Fetching information for Collateral Updates on ${market}`);

    const response: CollateralUpdates = [];
    const assets = await assetsSelectPrompt({
      message: 'Select the assets you want to amend',
      market,
    });
    for (const asset of assets) {
      console.log(`collecting info for ${asset}`);

      response.push({asset, ...(await fetchCollateralUpdate(market))});
    }
    return response;
  },
  build({market, cfg}) {
    assertReserveConfigChangeTestsSupported(market);
    const response: CodeArtifact = {
      code: {
        fn: [
          `function collateralsUpdates() public pure override returns (IAaveV3ConfigEngine.CollateralUpdate[] memory) {
          IAaveV3ConfigEngine.CollateralUpdate[] memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](${
            cfg.length
          });

          ${renderCollateralUpdates(market, cfg, 'collateralUpdate')}

          return collateralUpdate;
        }`,
        ],
      },
      test: {
        fn: collateralUpdateOverrides(market, cfg),
        reserveConfigChanges: true,
      },
    };
    return response;
  },
};
