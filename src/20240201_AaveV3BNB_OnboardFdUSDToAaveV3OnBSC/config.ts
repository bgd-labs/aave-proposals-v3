import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3BNB'],
    title: 'Onboard fdUSD to Aave v3 on BSC',
    shortName: 'OnboardFdUSDToAaveV3OnBSC',
    date: '20240201',
    author: 'ACI (Aave Chan Initiative)',
    discussion: 'https://governance.aave.com/t/arfc-onboard-fdusd-to-aave-v3-on-bsc/16364',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xedacc2aab061dbb187ef705ffee8a8f35ab3f53670e4d8e432eed9dfd2c31958',
  },
  poolOptions: {
    AaveV3BNB: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'FDUSD',
            decimals: 18,
            priceFeed: '0x390180e80058a8499930f0c13963ad3e0d86bfc9',
            ltv: '70',
            liqThreshold: '75',
            liqBonus: '5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'ENABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '8000000',
            borrowCap: '7500000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '6',
              variableRateSlope2: '75',
              stableRateSlope1: '20',
              stableRateSlope2: '300',
              baseStableRateOffset: '3',
              stableRateExcessOffset: '20',
              optimalStableToTotalDebtRatio: '20',
            },
            eModeCategory: 'AaveV3BNBEModes.NONE',
            asset: '0xc5f0f7b66764f6ec8c8dff7ba683102295e16409',
          },
        ],
      },
      cache: {blockNumber: 35751147},
    },
  },
};
