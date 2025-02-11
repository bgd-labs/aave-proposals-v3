import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Base'],
    title: 'Core & Base - BTC Correlated Asset Update',
    shortName: 'CoreBaseBTCCorrelatedAssetUpdate',
    date: '20250211',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-core-base-btc-correlated-asset-update/20940',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'cbBTC',
            params: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'WBTC',
            eModeCategory: 'AaveV3EthereumEModes.LBTC_WBTC',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'cbBTC',
            eModeCategory: 'AaveV3EthereumEModes.LBTC_WBTC',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'LBTC',
            eModeCategory: 'AaveV3EthereumEModes.LBTC_WBTC',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 21824305},
    },
    AaveV3Base: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'cbBTC',
            params: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
        EMODES_UPDATES: [
          {eModeCategory: 4, ltv: '84', liqThreshold: '86', liqBonus: '3', label: 'BTC_CORRELATED'},
        ],
        EMODES_ASSETS: [
          {
            asset: 'cbBTC',
            eModeCategory: 'AaveV3BaseEModes.ETH_CORRELATED',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'LBTC',
            decimals: 8,
            priceFeed: '0x1E6c22AAA11F507af12034A5Dc4126A6A25DC8d2',
            ltv: '70',
            liqThreshold: '75',
            liqBonus: '8.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '800',
            borrowCap: '80',
            rateStrategyParams: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '4',
              variableRateSlope2: '300',
            },
            asset: '0xecAc9C5F704e954931349Da37F60E39f515c11c1',
            admin: '',
          },
        ],
      },
      cache: {blockNumber: 26250029},
    },
  },
};
