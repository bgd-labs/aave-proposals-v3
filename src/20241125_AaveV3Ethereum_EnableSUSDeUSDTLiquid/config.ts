import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Enable sUSDe/USDT Liquid',
    shortName: 'EnableSUSDeUSDTLiquid',
    date: '20241125',
    discussion:
      'https://governance.aave.com/t/arfc-enable-susde-usdt-liquid-e-mode-on-core-instance/19939',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'USDT',
            eModeCategory: 'AaveV3EthereumEModes.SUSDE_STABLECOINS',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
        ],
      },
      cache: {blockNumber: 21266484},
    },
  },
};
