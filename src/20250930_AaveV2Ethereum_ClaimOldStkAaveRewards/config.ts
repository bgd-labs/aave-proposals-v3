import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum'],
    title: 'Claim Aave v2 stkAAVE rewards',
    shortName: 'ClaimOldStkAaveRewards',
    date: '20250930',
    author: 'BGD Labs (@bgdlabs)',
    discussion: '',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23474417}}},
};
