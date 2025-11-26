import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV2Ethereum'],
    title: 'Winding down Lend Migration Contract',
    shortName: 'WindingDownLendMigrationContract',
    date: '20251126',
    discussion: 'https://governance.aave.com/t/arfc-winding-down-lend-migration-contract/23126',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0x4d9eb143c46a637dbf98d63ad00a6e53739a9b6affc0eed7d3cd35680500afaa',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23881984}}},
};
