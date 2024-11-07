import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum'],
    title: 'GHO CCIP 1.5.0 Upgrade',
    shortName: 'GHOCCIP150Upgrade',
    date: '20241021',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/51',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21131872}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 271788784}},
  },
};
