import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Avalanche', 'AaveV3Gnosis', 'AaveV3BNB'],
    title: 'LayerZero bridge adapter update to V2',
    shortName: 'LayerZeroBridgeAdapterUpdateToV2',
    date: '20240322',
    discussion: '',
    snapshot: '',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19489240}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 54946269}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 43223949}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 33056141}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 37187776}},
  },
};
