import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'osETH Onboarding',
    shortName: 'OsETHOnboarding',
    date: '20240320',
    discussion: 'https://governance.aave.com/t/arfc-onboard-oseth-to-aave-v3-on-ethereum/16913',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x3dc8b06441d0f1dcd6f4a53d06d62e9bb1ac87ced19020d9c735854bbf68b835',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'osETH',
            decimals: 18,
            priceFeed: '0x0000000000000000000000000000000000000000',
            ltv: '71',
            liqThreshold: '76',
            liqBonus: '10',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '15000',
            borrowCap: '1000',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
              stableRateSlope1: '0',
              stableRateSlope2: '0',
              baseStableRateOffset: '0',
              stableRateExcessOffset: '0',
              optimalStableToTotalDebtRatio: '0',
            },
            eModeCategory: 'AaveV3EthereumEModes.NONE',
            asset: '0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38',
          },
        ],
      },
      cache: {blockNumber: 19478614},
    },
  },
};
