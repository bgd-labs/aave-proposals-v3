import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3Ethereum'],
    title: 'Grant Claim Helper Role to StkGhoMigrator',
    shortName: 'StkGhoMigratorClaimHelper',
    date: '20260623',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/direct-to-aip-stkgho-sgho-migration-tool/25250',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25378904}}},
};
