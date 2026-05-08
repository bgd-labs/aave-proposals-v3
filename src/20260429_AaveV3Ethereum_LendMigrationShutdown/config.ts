import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Winding Down the LEND Migration Contract',
    shortName: 'LendMigrationShutdown',
    date: '20260429',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-winding-down-lend-migration-contract/23126',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0x4d9eb143c46a637dbf98d63ad00a6e53739a9b6affc0eed7d3cd35680500afaa',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 25022080}}},
};
