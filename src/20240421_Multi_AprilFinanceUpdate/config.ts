import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum', 'AaveV2Polygon', 'AaveV3Gnosis'],
    title: 'April Finance Update',
    shortName: 'AprilFinanceUpdate',
    date: '20240421',
    author: '@karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-april-finance-update/17390',
    snapshot: '',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19706815}},
    AaveV2Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 56100553}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 33562797}},
  },
};
