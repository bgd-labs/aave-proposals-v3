import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Optimism', 'AaveV3Arbitrum'],
    title: 'May Funding Update',
    shortName: 'MayFundingUpdate',
    date: '20240603',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-may-funding-update/17768',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20369591}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 57725360}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 121928261}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 226121182}},
  },
};
