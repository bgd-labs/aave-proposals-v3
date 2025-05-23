import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'May Funding Part B',
    shortName: 'MayFundingPartB',
    date: '20250522',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-may-2025-funding-update/21906',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22537539}}},
};
