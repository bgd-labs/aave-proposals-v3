import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifier} from '../types';
import {toSolidityIdentifier} from '../common';
import {CollateralUpdate, CollateralUpdatePartial} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';
import {percentPrompt, translateJsPercentToSol} from '../prompts/percentPrompt';
import {testExecuteProposal} from '../utils/constants';

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

const KEEP_CURRENT = 'EngineFlags.KEEP_CURRENT';

function expectedConfigAssignment(
  varName: string,
  field: string,
  value: string,
  transform: (value: string) => string = (value) => value,
) {
  const translated = translateJsPercentToSol(value);
  if (translated === KEEP_CURRENT) return '';
  return `${varName}.${field} = ${transform(translated)};`;
}

function collateralUpdateTests(market: MarketIdentifier, cfgs: CollateralUpdates): string[] {
  const expectations = cfgs
    .map((cfg) => {
      const asset = translateAssetToAssetLibUnderlying(cfg.asset, market);
      const varName = `expected_${toSolidityIdentifier(cfg.asset)}`;
      return `ReserveConfig memory ${varName} = _findReserveConfig(allConfigsBefore, ${asset});
      ${[
        expectedConfigAssignment(varName, 'ltv', cfg.ltv),
        expectedConfigAssignment(varName, 'liquidationThreshold', cfg.liqThreshold),
        expectedConfigAssignment(
          varName,
          'liquidationBonus',
          cfg.liqBonus,
          (value) => `100_00 + ${value}`,
        ),
        expectedConfigAssignment(varName, 'liquidationProtocolFee', cfg.liqProtocolFee),
      ]
        .filter(Boolean)
        .join('\n')}
      ${varName}.usageAsCollateralEnabled = ${varName}.liquidationThreshold != 0;
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
    const response: CodeArtifact = {
      code: {
        fn: [
          `function collateralsUpdates() public pure override returns (IAaveV3ConfigEngine.CollateralUpdate[] memory) {
          IAaveV3ConfigEngine.CollateralUpdate[] memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `collateralUpdate[${ix}] = IAaveV3ConfigEngine.CollateralUpdate({
               asset: ${translateAssetToAssetLibUnderlying(cfg.asset, market)},
               ltv: ${translateJsPercentToSol(cfg.ltv)},
               liqThreshold: ${translateJsPercentToSol(cfg.liqThreshold)},
               liqBonus: ${translateJsPercentToSol(cfg.liqBonus)},
               liqProtocolFee: ${translateJsPercentToSol(cfg.liqProtocolFee)}
             });`,
            )
            .join('\n')}

          return collateralUpdate;
        }`,
        ],
      },
      test: {
        fn: collateralUpdateTests(market, cfg),
      },
    };
    return response;
  },
};
