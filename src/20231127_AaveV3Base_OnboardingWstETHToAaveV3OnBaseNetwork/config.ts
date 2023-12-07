import {ConfigFile} from '../../generator/types';

export const config: ConfigFile = {
  rootOptions: {
    author: 'Alice Rozengarden (@Rozengarden - Aave-chan initiative)',
    pools: ['AaveV3Base'],
    title: 'Onboarding wstETH to Aave V3 on Base Network',
    shortName: 'OnboardingWstETHToAaveV3OnBaseNetwork',
    date: '20231127',
    discussion:
      'https://governance.aave.com/t/arfc-onboarding-wsteth-to-aave-v3-on-base-network/15510/5',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x9cf4ba743e0363f77fbbd1bf0d3946b06154abd57cd4bc897c23cdfcdb3bcbeb',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'wstETH',
            decimals: 18,
            priceFeed: '0xB88BAc61a4Ca37C43a3725912B1f472c9A5bc061',
            ltv: '71',
            liqThreshold: '76',
            liqBonus: '6',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '4000',
            borrowCap: '400',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
              stableRateSlope1: '13',
              stableRateSlope2: '300',
              baseStableRateOffset: '3',
              stableRateExcessOffset: '5',
              optimalStableToTotalDebtRatio: '20',
            },
            eModeCategory: 'AaveV3BaseEModes.ETH_CORRELATED',
            asset: '0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452',
          },
        ],
      },
      cache: {
        blockNumber: 7156340,
      },
    },
  },
};
