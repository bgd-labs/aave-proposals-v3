import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum'],
    title: 'GHO CCIP 1.5.1 Upgrade',
    shortName: 'GHOCCIP151Upgrade',
    date: '20241209',
    author: 'Aave Labs',
    discussion: '',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21564756}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 292550754}},
  },
};
