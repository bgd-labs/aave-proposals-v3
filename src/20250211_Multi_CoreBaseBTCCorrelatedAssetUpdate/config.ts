import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Base'],
    title: 'Core & Base - BTC Correlated Asset Update',
    shortName: 'CoreBaseBTCCorrelatedAssetUpdate',
    date: '20250211',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-core-base-btc-correlated-asset-update/20940',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x9efbc881d7db09b549a4c342387c31149c066de4bc51b625e2213d43aee0e977',
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
              variableRateSlope2: '60',
            },
          },
          {
            asset: 'tBTC',
            params: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '60',
            },
          },
        ],
        BORROWS_UPDATE: [
          {
            asset: 'cbBTC',
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '50',
          },
          {
            asset: 'tBTC',
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '50',
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3EthereumEModes.LBTC_WBTC',
            ltv: 'KEEP_CURRENT',
            liqThreshold: 'KEEP_CURRENT',
            liqBonus: 'KEEP_CURRENT',
            label: 'LBTC_WBTC',
          },
          {
            eModeCategory: '5',
            ltv: '84',
            liqThreshold: '86',
            liqBonus: '3',
            label: 'LBTC_cbBTC',
          },
          {
            eModeCategory: '6',
            ltv: '84',
            liqThreshold: '86',
            liqBonus: '3',
            label: 'LBTC_tBTC',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'cbBTC',
            eModeCategory: '5',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'tBTC',
            eModeCategory: '6',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'LBTC',
            eModeCategory: '5',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'LBTC',
            eModeCategory: '6',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 21945497},
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
              variableRateSlope2: '60',
            },
          },
        ],
        BORROWS_UPDATE: [
          {
            asset: 'cbBTC',
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '50',
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 4,
            ltv: '82',
            liqThreshold: '84',
            liqBonus: '3',
            label: 'LBTC_cbBTC',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'cbBTC',
            eModeCategory: '4',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'LBTC',
            eModeCategory: '4',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'LBTC',
            decimals: 8,
            priceFeed: '0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F',
            ltv: '70',
            liqThreshold: '75',
            liqBonus: '8.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '50',
            supplyCap: '800',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '4',
              variableRateSlope2: '300',
            },
            asset: '0xecAc9C5F704e954931349Da37F60E39f515c11c1',
            admin: '',
            eModeCategory: '4',
          },
        ],
      },
      cache: {blockNumber: 26982148},
    },
  },
};
