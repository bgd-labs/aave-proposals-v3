import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido', 'AaveV3Arbitrum', 'AaveV3Base'],
    title: 'LRT and wstETH Unification Summary',
    shortName: 'LRTAndWstETHUnificationSummary',
    date: '20250324',
    author: 'TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-core-instance-add-ezeth-and-update-rseth-emode-parameters/21505',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        CAPS_UPDATE: [{asset: 'rsETH', supplyCap: '550000', borrowCap: ''}],
        EMODES_UPDATES: [
          {eModeCategory: 7, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'ezETH_WETH'},
          {eModeCategory: 8, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'ezETH_wstETH'},
          {eModeCategory: 9, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'rsETH_WETH'},
          {eModeCategory: 10, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'weETH_WETH'},
          {eModeCategory: 11, ltv: '94.5', liqThreshold: '96', liqBonus: '1', label: 'wstETH_WETH'},
          {eModeCategory: 12, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'rsETH_wstETH'},
        ],
        EMODES_ASSETS: [
          {
            asset: 'ezETH',
            eModeCategory: '7',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'WETH',
            eModeCategory: '7',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'ezETH',
            eModeCategory: '8',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'wstETH',
            eModeCategory: '8',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'rsETH',
            eModeCategory: '9',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'WETH',
            eModeCategory: '9',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'weETH',
            eModeCategory: '10',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'WETH',
            eModeCategory: '10',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'wstETH',
            eModeCategory: '11',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'WETH',
            eModeCategory: '11',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'rsETH',
            eModeCategory: '12',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'wstETH',
            eModeCategory: '12',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3EthereumEModes.RSETH_LST_MAIN',
            collateral: 'DISABLED',
            borrowable: 'DISABLED',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'ezETH',
            decimals: 18,
            priceFeed: '0x68C9c7Bf43DBd0EBab102116bc7C3C9f7d9297Ee',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '150000',
            borrowCap: '0',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            asset: '0xbf5495Efe5DB9ce00f80364C8B423567e58d2110',
            admin: '',
          },
        ],
      },
      cache: {blockNumber: 22117289},
    },
    AaveV3EthereumLido: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 6, ltv: '94.5', liqThreshold: '96', liqBonus: '1', label: 'wstETH_WETH'},
          {
            eModeCategory: 'AaveV3EthereumLidoEModes.RSETH_LST_MAIN',
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '',
            label: 'rsETH_wstETH',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'wstETH',
            eModeCategory: '6',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'WETH',
            eModeCategory: '6',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
        ],
      },
      cache: {blockNumber: 22117340},
    },
    AaveV3Arbitrum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'weETH',
            ltv: '75',
            liqThreshold: '77',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
        EMODES_UPDATES: [
          {eModeCategory: 5, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'weETH_WETH'},
          {eModeCategory: 6, ltv: '94.5', liqThreshold: '96', liqBonus: '1', label: 'wstETH_WETH'},
        ],
        EMODES_ASSETS: [
          {
            asset: 'WETH',
            eModeCategory: '5',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'weETH',
            eModeCategory: '5',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'WETH',
            eModeCategory: '6',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'wstETH',
            eModeCategory: '6',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 319130628},
    },
    AaveV3Base: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'weETH',
            ltv: '75',
            liqThreshold: '77',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
        EMODES_UPDATES: [
          {eModeCategory: 6, ltv: '93', liqThreshold: '95', liqBonus: '1.25', label: 'weETH_WETH'},
          {eModeCategory: 7, ltv: '94.5', liqThreshold: '96', liqBonus: '1', label: 'wstETH_WETH'},
        ],
        EMODES_ASSETS: [
          {
            asset: 'WETH',
            eModeCategory: '6',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'weETH',
            eModeCategory: '6',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'WETH',
            eModeCategory: '7',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'wstETH',
            eModeCategory: '7',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 28018714},
    },
  },
};
