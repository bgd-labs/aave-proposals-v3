import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'February 2026 - Funding Update',
    shortName: 'February2026FundingUpdate',
    date: '20260206',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24399516}}},
};
