import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'EventsGrant2025',
    shortName: 'EventsGrant2025',
    date: '20250612',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-aave-events-sponsorship-budget-2025/22173',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x12ae50ccd9a4cd8edfead63d773e62ca23ea567a458c442557e0b6193e01bb1d',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 22689071}}},
};
