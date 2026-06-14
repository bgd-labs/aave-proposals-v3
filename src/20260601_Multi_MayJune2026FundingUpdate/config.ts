import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Plasma'],
    title: 'May/June 2026 Funding Update',
    shortName: 'MayJune2026FundingUpdate',
    date: '20260601',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/direct-to-aip-may-june-2026-funding-update/25000',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25274433}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 23376630}},
  },
};
