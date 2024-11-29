import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'test',
    shortName: 'Test',
    date: '20241129',
    author: 'test',
    discussion: 'test',
    snapshot: 'test',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3EthereumLidoEModes.ETH_CORRELATED',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            label: '0',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'ezETH',
            eModeCategory: 'AaveV3EthereumLidoEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'KEEP_CURRENT',
          },
          {
            asset: 'sUSDe',
            eModeCategory: 'AaveV3EthereumLidoEModes.SUSDE_STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'KEEP_CURRENT',
          },
        ],
      },
      cache: {blockNumber: 21294440},
    },
  },
};
