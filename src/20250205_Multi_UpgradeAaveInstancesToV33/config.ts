import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: [
      'AaveV3Ethereum',
      'AaveV3EthereumLido',
      'AaveV3EthereumEtherFi',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Metis',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Scroll',
      'AaveV3BNB',
      'AaveV3ZkSync',
      'AaveV3Linea',
    ],
    title: 'Upgrade Aave instances to v3.3',
    shortName: 'UpgradeAaveInstancesToV33',
    date: '20250205',
    discussion: 'https://governance.aave.com/t/bgd-aave-v3-3-feat-umbrella/20129',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21782908}},
    AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 21782908}},
    AaveV3EthereumEtherFi: {configs: {OTHERS: {}}, cache: {blockNumber: 21782908}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 67581755}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 56890263}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 131595617}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 303014365}},
    AaveV3Metis: {configs: {OTHERS: {}}, cache: {blockNumber: 19657189}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 26000336}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 38412983}},
    AaveV3Scroll: {configs: {OTHERS: {}}, cache: {blockNumber: 13226231}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 46402891}},
    AaveV3ZkSync: {configs: {OTHERS: {}}, cache: {blockNumber: 55353716}},
    AaveV3Linea: {configs: {OTHERS: {}}, cache: {blockNumber: 15472291}},
  },
};
