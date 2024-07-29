import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    title: 'Gho Steward CCIP Extension',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-extend-gho-stewards-to-arbitrum/18298',
    snapshot: '',
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum'],
    shortName: 'GhoStewardCCIPExtension',
    date: '20240726',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20393794}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 236392797}},
  },
};
