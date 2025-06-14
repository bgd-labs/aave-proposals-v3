import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'June Funding Update',
    shortName: 'JuneFundingUpdate',
    date: '20250613',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/direct-to-aip-june-2025-funding-update/22352',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22697434}}},
};
