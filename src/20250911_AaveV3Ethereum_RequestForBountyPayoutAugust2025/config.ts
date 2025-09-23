import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Request for Bounty Payout - August 2025',
    shortName: 'RequestForBountyPayoutAugust2025',
    date: '20250911',
    author: 'BGD Labs @bgdlabs',
    discussion: 'https://governance.aave.com/t/bgd-request-for-bounty-payout-august-2025/23096',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23341425}}},
};
