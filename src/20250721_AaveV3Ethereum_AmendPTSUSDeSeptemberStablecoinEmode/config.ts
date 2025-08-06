import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250721_AaveV3Ethereum_AmendPTSUSDeSeptemberStablecoinEmode/config.ts',
    force: true,
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'amend PT-sUSDe september stablecoin emode',
    shortName: 'AmendPTSUSDeSeptemberStablecoinEmode',
    date: '20250721',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-adjustment-of-pt-susde-september-e-mode-and-usdtb-ir-curve/22615',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'sUSDe',
            eModeCategory: 'AaveV3EthereumEModes.PT_SUSDE_STABLECOINS_SEPTEMBER_2025',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'PT_sUSDE_31JUL2025',
            eModeCategory: 'AaveV3EthereumEModes.PT_SUSDE_STABLECOINS_SEPTEMBER_2025',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDtb',
            eModeCategory: 'AaveV3EthereumEModes.PT_SUSDE_STABLECOINS_SEPTEMBER_2025',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
        ],
      },
      cache: {blockNumber: 22969892},
    },
  },
};
