import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3Ethereum'],
    title: 'StkGhoMigratorClaimHelper',
    shortName: 'StkGhoMigratorClaimHelper',
    date: '20260623',
    author: 'Aave Labs',
    discussion: '',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25378904}}},
};
