import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Metis',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Scroll',
    ],
    title: 'Native bridge adapters update',
    shortName: 'NativeBridgeAdaptersUpdate',
    date: '20240322',
    discussion: '',
    snapshot: '',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19490720}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 54954005}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 117759224}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 193049277}},
    AaveV3Metis: {configs: {OTHERS: {}}, cache: {blockNumber: 15632608}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 12163947}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 33059583}},
    AaveV3Scroll: {configs: {OTHERS: {}}, cache: {blockNumber: 4339218}},
  },
};
