import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifier} from '../types';
import {getMarketChain, toSolidityIdentifier} from '../common';
import {CapsUpdate, CapsUpdatePartial} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';
import {numberPrompt, translateJsNumberToSol} from '../prompts/numberPrompt';
import {testExecuteProposal} from '../utils/constants';
import {expectedConfigAssignment} from './reserveConfigTestHelpers';

export async function fetchCapsUpdate(required?: boolean): Promise<CapsUpdatePartial> {
  return {
    supplyCap: await numberPrompt({
      message: 'New supply cap',
      required,
    }),
    borrowCap: await numberPrompt({
      message: 'New borrow cap (must be 1 for asset not borrowable)',
      required,
    }),
  };
}

type CapsUpdates = CapsUpdate[];

function renderCapsUpdateEntries(market: MarketIdentifier, cfgs: CapsUpdates, varName: string) {
  return cfgs
    .map(
      (cfg, ix) => `${varName}[${ix}] = IAaveV3ConfigEngine.CapsUpdate({
               asset: ${translateAssetToAssetLibUnderlying(cfg.asset, market)},
               supplyCap: ${translateJsNumberToSol(cfg.supplyCap)},
               borrowCap: ${translateJsNumberToSol(cfg.borrowCap)}
             });`,
    )
    .join('\n');
}

function zksyncCapsUpdateTests(market: MarketIdentifier, cfgs: CapsUpdates): string[] {
  const expectations = cfgs
    .map((cfg) => {
      const asset = translateAssetToAssetLibUnderlying(cfg.asset, market);
      const varName = `expected_${toSolidityIdentifier(cfg.asset)}`;
      return `ReserveConfig memory ${varName} = _findReserveConfig(allConfigsBefore, ${asset});
      ${[
        expectedConfigAssignment(varName, 'supplyCap', cfg.supplyCap, translateJsNumberToSol),
        expectedConfigAssignment(varName, 'borrowCap', cfg.borrowCap, translateJsNumberToSol),
      ]
        .filter(Boolean)
        .join('\n')}
      _validateReserveConfig(${varName}, allConfigsAfter);`;
    })
    .join('\n\n');

  return [
    `function test_capsUpdatesConfiguration() public {
      ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(${market}.POOL);
      ${testExecuteProposal(market)}
      ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(${market}.POOL);

      ${expectations}
    }`,
  ];
}

function capsUpdateOverrides(market: MarketIdentifier, cfgs: CapsUpdates): string[] {
  return [
    `function _expectedCapsChanges() internal pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
      IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate;
      capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](${cfgs.length});

      ${renderCapsUpdateEntries(market, cfgs, 'capsUpdate')}
      return capsUpdate;
    }`,
  ];
}

export const capsUpdates: FeatureModule<CapsUpdates> = {
  value: FEATURE.CAPS_UPDATE,
  description: 'CapsUpdates (supplyCap, borrowCap)',
  async cli({market}) {
    console.log(`Fetching information for CapsUpdates on ${market}`);
    const assets = await assetsSelectPrompt({
      message: 'Select the assets you want to amend',
      market,
    });

    const response: CapsUpdates = [];
    for (const asset of assets) {
      console.log(`collecting info for ${asset}`);
      response.push({asset, ...(await fetchCapsUpdate())});
    }
    return response;
  },
  build({market, cfg}) {
    const useReserveConfigChangesBase = getMarketChain(market) !== 'ZkSync';
    const response: CodeArtifact = {
      code: {
        fn: [
          `function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
          IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](${
            cfg.length
          });

          ${renderCapsUpdateEntries(market, cfg, 'capsUpdate')}

          return capsUpdate;
        }`,
        ],
      },
      test: {
        fn: useReserveConfigChangesBase
          ? capsUpdateOverrides(market, cfg)
          : zksyncCapsUpdateTests(market, cfg),
        reserveConfigChanges: useReserveConfigChangesBase,
      },
    };
    return response;
  },
};
