import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    title: 'Events Grant 2024',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-aave-events-sponsorship-proposal-2024/18276',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x5d4e3fba58f76f516afd0855a687027270b74163911116f14a4f5c01c34a9bd9',
    pools: ['AaveV3Ethereum'],
    shortName: 'EventsGrant2024',
    date: '20240718',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20336106}}},
};
