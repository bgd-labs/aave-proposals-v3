import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile:
      'src/20251128_AaveV3Ethereum_AddSUSDeToPTUSDeAndPTSUSDeFebruaryExpiryEmode/config.ts',
    force: true,
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'add sUSDe to PT USDe and PT sUSDe february expiry emode',
    shortName: 'AddSUSDeToPTUSDeAndPTSUSDeFebruaryExpiryEmode',
    date: '20251128',
    discussion: '',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'sUSDe',
            eModeCategory:
              'AaveV3EthereumEModes.PT_USDe_27NOV2025_PT_USDe_5FEB2026__USDC_USDT_USDe_USDtb',
            collateral: 'ENABLED',
            borrowable: 'KEEP_CURRENT',
          },
          {
            asset: 'sUSDe',
            eModeCategory: 'AaveV3EthereumEModes.PT_USDe_27NOV2025_PT_USDe_5FEB2026__USDe',
            collateral: 'ENABLED',
            borrowable: 'KEEP_CURRENT',
          },
          {
            asset: 'sUSDe',
            eModeCategory:
              'AaveV3EthereumEModes.PT_sUSDE_27NOV2025_PT_sUSDE_5FEB2026__USDC_USDT_USDe_USDtb',
            collateral: 'ENABLED',
            borrowable: 'KEEP_CURRENT',
          },
          {
            asset: 'sUSDe',
            eModeCategory: 'AaveV3EthereumEModes.PT_sUSDE_27NOV2025_PT_sUSDE_5FEB2026__USDe',
            collateral: 'ENABLED',
            borrowable: 'KEEP_CURRENT',
          },
        ],
      },
      cache: {blockNumber: 23896519},
    },
  },
};
