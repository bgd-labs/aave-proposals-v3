import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifier} from '../types';
import {getMarketChain, toSolidityIdentifier} from '../common';
import {CollateralUpdate, CollateralUpdatePartial} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';
import {percentPrompt, translateJsPercentToSol} from '../prompts/percentPrompt';
import {testExecuteProposal} from '../utils/constants';
import {expectedConfigAssignment, KEEP_CURRENT} from './reserveConfigTestHelpers';

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

function usageAsCollateralAssignment(varName: string, liqThreshold: string) {
  if (translateJsPercentToSol(liqThreshold) === KEEP_CURRENT) return '';
  return `${varName}.usageAsCollateralEnabled = ${varName}.liquidationThreshold != 0;`;
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

function zksyncCollateralUpdateTests(market: MarketIdentifier, cfgs: CollateralUpdates): string[] {
  const expectations = cfgs
    .map((cfg) => {
      const asset = translateAssetToAssetLibUnderlying(cfg.asset, market);
      const varName = `expected_${toSolidityIdentifier(cfg.asset)}`;
      return `ReserveConfig memory ${varName} = _findReserveConfig(allConfigsBefore, ${asset});
      ${[
        expectedConfigAssignment(varName, 'ltv', cfg.ltv, translateJsPercentToSol),
        expectedConfigAssignment(
          varName,
          'liquidationThreshold',
          cfg.liqThreshold,
          translateJsPercentToSol,
        ),
        expectedConfigAssignment(
          varName,
          'liquidationBonus',
          cfg.liqBonus,
          translateJsPercentToSol,
          (value) => `100_00 + ${value}`,
        ),
        expectedConfigAssignment(
          varName,
          'liquidationProtocolFee',
          cfg.liqProtocolFee,
          translateJsPercentToSol,
        ),
        usageAsCollateralAssignment(varName, cfg.liqThreshold),
      ]
        .filter(Boolean)
        .join('\n')}
      _validateReserveConfig(${varName}, allConfigsAfter);`;
    })
    .join('\n\n');

  return [
    `function test_collateralUpdatesConfiguration() public {
      ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(${market}.POOL);
      ${testExecuteProposal(market)}
      ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(${market}.POOL);

      ${expectations}
    }`,
  ];
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
    const useReserveConfigChangesBase = getMarketChain(market) !== 'ZkSync';
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
        fn: useReserveConfigChangesBase
          ? collateralUpdateOverrides(market, cfg)
          : zksyncCollateralUpdateTests(market, cfg),
        reserveConfigChanges: useReserveConfigChangesBase,
      },
    };
    return response;
  },
};
