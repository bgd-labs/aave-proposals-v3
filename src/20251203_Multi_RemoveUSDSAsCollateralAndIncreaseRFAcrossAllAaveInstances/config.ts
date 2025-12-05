import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile:
      'src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/config.ts',
    force: true,
    author: 'Aave-chan Initiative',
    title: 'Remove USDS as collateral and increase RF across all Aave Instances',
    discussion:
      'https://governance.aave.com/t/arfc-remove-usds-as-collateral-and-increase-rf-across-all-aave-instances/23426',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0xeb05b887d9db47d2f4a42d4f4fcb7141080d091dc8c1b32e9a75597071f949ea',
    votingNetwork: ['AVALANCHE'],
    pools: [
      'AaveV3Ethereum',
      'AaveV3EthereumLido',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Metis',
    ],
    shortName: 'RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances',
    date: '20251203',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        CAPS_UPDATE: [
          {asset: 'DAI', supplyCap: '200000000', borrowCap: '180000000'},
          {asset: 'USDS', supplyCap: '160000000', borrowCap: '144000000'},
        ],
        COLLATERALS_UPDATE: [
          {
            asset: 'USDS',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'DAI',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '25',
            asset: 'USDS',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'USDS',
            eModeCategory: 'AaveV3EthereumEModes.USDe_sUSDe__USDC_USDT_USDS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDS',
            eModeCategory: 'AaveV3EthereumEModes.sUSDe_PT_sUSDE_31JUL2025__USDC_USDT_USDS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDS',
            eModeCategory: 'AaveV3EthereumEModes.PT_eUSDE_29MAY2025_eUSDe__USDC_USDT_USDS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDS',
            eModeCategory: 'AaveV3EthereumEModes.USDe_PT_USDe_31JUL2025__USDC_USDT_USDS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDS',
            eModeCategory: 'AaveV3EthereumEModes.USDe__USDC_USDT_USDS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDS',
            eModeCategory: 'AaveV3EthereumEModes.PT_eUSDE_14AUG2025_eUSDe__USDC_USDT_USDS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDS',
            eModeCategory: 'AaveV3EthereumEModes.eUSDe__USDC_USDT_USDS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDS',
            eModeCategory:
              'AaveV3EthereumEModes.sUSDe_PT_sUSDE_31JUL2025_PT_sUSDE_25SEP2025__USDC_USDT_USDe_USDS_USDtb',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDS',
            eModeCategory:
              'AaveV3EthereumEModes.USDe_PT_USDe_31JUL2025_PT_eUSDE_14AUG2025_PT_USDe_25SEP2025__USDC_USDT_USDe_USDS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDS',
            eModeCategory:
              'AaveV3EthereumEModes.sUSDe_PT_sUSDE_25SEP2025_PT_sUSDE_27NOV2025__USDC_USDT_USDe_USDS_USDtb',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDS',
            eModeCategory:
              'AaveV3EthereumEModes.PT_USDe_25SEP2025_PT_USDe_27NOV2025__USDC_USDT_USDe_USDS_USDtb',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 23933369},
    },
    AaveV3EthereumLido: {
      configs: {
        CAPS_UPDATE: [{asset: 'USDS', supplyCap: '40000000', borrowCap: '36000000'}],
        EMODES_ASSETS: [
          {
            asset: 'USDS',
            eModeCategory: 'AaveV3EthereumLidoEModes.ezETH__USDS_USDC_GHO',
            collateral: 'KEEP_CURRENT',
            borrowable: 'ENABLED',
          },
          {
            asset: 'USDS',
            eModeCategory: 'AaveV3EthereumLidoEModes.rsETH__USDS_USDC_GHO',
            collateral: 'KEEP_CURRENT',
            borrowable: 'ENABLED',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '25',
            asset: 'USDS',
          },
        ],
      },
      cache: {blockNumber: 23933381},
    },
    AaveV3Polygon: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'DAI',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 79832796},
    },
    AaveV3Avalanche: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'DAIe',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 73032650},
    },
    AaveV3Optimism: {
      configs: {
        CAPS_UPDATE: [{asset: 'DAI', supplyCap: '2000000', borrowCap: '1800000'}],
        COLLATERALS_UPDATE: [
          {
            asset: 'DAI',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 144585944},
    },
    AaveV3Arbitrum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'DAI',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 406760422},
    },
    AaveV3Metis: {
      configs: {
        CAPS_UPDATE: [{asset: 'mDAI', supplyCap: '200000', borrowCap: '180000'}],
        COLLATERALS_UPDATE: [
          {
            asset: 'mDAI',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 21738872},
    },
  },
};
