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
          {
            eModeCategory: 11,
            ltv: '93.5',
            liqThreshold: '95.5',
            liqBonus: '1',
            label: 'wstETH_WETH',
          },
          {eModeCategory: 12, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'rsETH_wstETH'},
        ],
        EMODES_ASSETS: [
          {
            asset: 'WETH',
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'ENABLED',
          },
          {
            asset: 'weETH',
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            collateral: 'ENABLED',
            borrowable: 'KEEP_CURRENT',
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
            eModeCategory: 'AaveV3EthereumLidoEModes.ETH_CORRELATED',
            ltv: '94.5',
            liqThreshold: '96',
            liqBonus: '1',
            label: 'asdf',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3EthereumLidoEModes.ETH_CORRELATED',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'WETH',
            eModeCategory: 'AaveV3EthereumLidoEModes.ETH_CORRELATED',
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
            asset: 'WETH',
            ltv: '1',
            liqThreshold: '1',
            liqBonus: '1',
            debtCeiling: '1',
            liqProtocolFee: '1',
          },
          {
            asset: 'wstETH',
            ltv: '1',
            liqThreshold: '1',
            liqBonus: '1',
            debtCeiling: '1',
            liqProtocolFee: '1',
          },
        ],
        EMODES_UPDATES: [
          {eModeCategory: 5, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'weETH_WETH'},
          {eModeCategory: 6, ltv: '94.5', liqThreshold: '96', liqBonus: '1', label: 'wstETH_WETH'},
        ],
        EMODES_ASSETS: [
          {
            asset: 'WETH',
            eModeCategory: 'AaveV3ArbitrumEModes.ETH_CORRELATED',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3ArbitrumEModes.ETH_CORRELATED',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 69444973},
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
            eModeCategory: 'AaveV3BaseEModes.ETH_CORRELATED',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'weETH',
            eModeCategory: 'AaveV3BaseEModes.ETH_CORRELATED',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 28018714},
    },
  },
};
