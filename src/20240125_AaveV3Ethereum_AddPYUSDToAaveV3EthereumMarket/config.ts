import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Add PYUSD to Aave v3 Ethereum Market',
    shortName: 'AddPYUSDToAaveV3EthereumMarket',
    date: '20240125',
    author: 'JosepBove (ACI)',
    discussion: 'https://governance.aave.com/t/arfc-add-pyusd-to-aave-v3-ethereum-market/16218/',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xb91949efad61b134b913d93b00f73ca8a122259e6d1458cf793f22a0eebfd5d5',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'PYUSD',
            decimals: 6,
            priceFeed: '0x8f1df6d7f2db73eece86a18b4381f4707b918fb1',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'DISABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '10000000',
            borrowCap: '9000000',
            rateStrategyParams: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '6',
              variableRateSlope2: '80',
              stableRateSlope1: '13',
              stableRateSlope2: '300',
              baseStableRateOffset: '3',
              stableRateExcessOffset: '8',
              optimalStableToTotalDebtRatio: '20',
            },
            eModeCategory: 'AaveV3EthereumEModes.NONE',
            asset: '0x6c3ea9036406852006290770bedfcaba0e23a0e8',
          },
        ],
      },
      cache: {blockNumber: 19084159},
    },
  },
};
