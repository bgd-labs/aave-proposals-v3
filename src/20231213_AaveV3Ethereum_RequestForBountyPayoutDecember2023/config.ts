import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Request for Bounty Payout - December 2023',
    shortName: 'RequestForBountyPayoutDecember2023',
    date: '20231213',
    author: 'BGD Labs @bgdlabs',
    discussion: 'https://governance.aave.com/t/bgd-request-for-bounty-payout-december-2023/15826',
    snapshot: '',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 18777690}}},
};
