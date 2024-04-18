import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum', 'AaveV2Polygon', 'AaveV2Avalanche'],
    title: 'Temporary Freeze of Long-Tail V2 Assets',
    shortName: 'TemporaryFreezeOfLongTailV2Assets',
    date: '20240418',
    author: 'Chaos Labs',
    discussion: 'https://governance.aave.com/t/arfc-temporary-freeze-of-long-tail-v2-assets/17403',
    snapshot: '',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19682923}},
    AaveV2Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 55970246}},
    AaveV2Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 44360962}},
  },
};
