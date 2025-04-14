import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Request for Bounty Payout - March 2025',
    shortName: 'RequestForBountyPayoutMarch2025',
    date: '20250404',
    author: 'BGD Labs @bgdlabs',
    discussion: 'https://governance.aave.com/t/bgd-request-for-bounty-payout-march-2025/21656',
    snapshot: 'N/A',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22194992}}},
};
