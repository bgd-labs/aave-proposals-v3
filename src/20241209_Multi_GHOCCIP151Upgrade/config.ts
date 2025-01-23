import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum'],
    title: 'GHO CCIP 1.5.1 Upgrade',
    shortName: 'GHOCCIP151Upgrade',
    date: '20241209',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/technical-maintenance-proposals/15274/59',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21594804}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 293994020}},
  },
};
