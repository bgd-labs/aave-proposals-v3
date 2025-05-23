import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Metis',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Scroll',
      'AaveV3BNB',
    ],
    title: 'Update Price Cap Adapters (CAPO)',
    shortName: 'UpdatePriceCapAdaptersCAPO',
    date: '20241101',
    author: 'BGD Labs (@bgdlabs)',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21092620}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 63752907}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 52520148}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 127431611}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 269904022}},
    AaveV3Metis: {configs: {OTHERS: {}}, cache: {blockNumber: 18853015}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 21836329}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 36800741}},
    AaveV3Scroll: {configs: {OTHERS: {}}, cache: {blockNumber: 10718504}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 43627345}},
  },
};
