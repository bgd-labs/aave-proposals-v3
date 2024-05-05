import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum'],
    title: 'weETH Arbitrum onboarding',
    shortName: 'WeETHArbitrumOnboarding',
    date: '20240409',
    author: '@mzeller - ACI',
    discussion: 'https://governance.aave.com/t/arfc-onboard-weeth-to-aave-v3-on-ethereum/16758/11',
    snapshot: 'direct-to-aip',
  },
  poolOptions: {
    AaveV3Arbitrum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'weETH',
            decimals: 18,
            priceFeed: '0x517276B5972C4Db7E88B9F76Ee500E888a2D73C3',
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
            reserveFactor: '15',
            supplyCap: '1000',
            borrowCap: '100',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
              stableRateSlope1: '7',
              stableRateSlope2: '300',
              baseStableRateOffset: '2',
              stableRateExcessOffset: '20',
              optimalStableToTotalDebtRatio: '20',
            },
            eModeCategory: 'AaveV3ArbitrumEModes.ETH_CORRELATED',
            asset: '0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe',
          },
        ],
      },
      cache: {blockNumber: 199243484},
    },
  },
};
