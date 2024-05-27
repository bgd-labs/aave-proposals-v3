import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Base'],
    title: 'weETH Aave V3 Base Onboarding',
    shortName: 'WeETHAaveV3BaseOnboarding',
    date: '20240527',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-onboarding-of-weeth-to-aave-v3-on-base/17691',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'weETH',
            decimals: 18,
            priceFeed: '0xFc4d1d7a8FD1E6719e361e16044b460737F12C44',
            ltv: '72.5',
            liqThreshold: '75',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '45',
            supplyCap: '150',
            borrowCap: '30',
            rateStrategyParams: {
              optimalUtilizationRate: '35',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
              stableRateSlope1: '7',
              stableRateSlope2: '300',
              baseStableRateOffset: '20',
              stableRateExcessOffset: '20',
              optimalStableToTotalDebtRatio: '20',
            },
            eModeCategory: 'AaveV3BaseEModes.ETH_CORRELATED',
            asset: '0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A',
          },
        ],
      },
      cache: {blockNumber: 15006009},
    },
  },
};
