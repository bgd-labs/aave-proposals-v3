import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum', 'AaveV3Polygon', 'AaveV3Avalanche', 'AaveV3Optimism'],
    title: 'September Funding Update Part A',
    shortName: 'SeptemberFundingUpdatePartA',
    date: '20241020',
    author: '@karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-september-funding-update/19162',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21010553}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 63291551}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 52040278}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 126936973}},
  },
};
