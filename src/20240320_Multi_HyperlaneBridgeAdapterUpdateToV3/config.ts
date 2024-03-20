import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Avalanche', 'AaveV3Gnosis', 'AaveV3BNB'],
    title: 'Hyperlane bridge adapter update to V3',
    shortName: 'HyperlaneBridgeAdapterUpdateToV3',
    date: '20240320',
    discussion: '',
    snapshot: '',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19476776}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 54882095}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 43150105}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 33027304}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 37137492}},
  },
};
