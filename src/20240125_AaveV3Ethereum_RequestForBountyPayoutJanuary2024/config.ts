import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Request for Bounty Payout - January 2024',
    shortName: 'RequestForBountyPayoutJanuary2024',
    date: '20240125',
    author: 'BGD Labs @bgdlabs',
    discussion: 'https://governance.aave.com/t/bgd-request-for-bounty-payout-january-2024/16378',
    snapshot: 'N/A',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19080922}}},
};
