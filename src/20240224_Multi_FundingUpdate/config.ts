import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Polygon'],
    title: 'Funding Update',
    shortName: 'FundingUpdate',
    date: '20240224',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-funding-update/16675',
    snapshot: '',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19300831}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 53919052}},
  },
};
