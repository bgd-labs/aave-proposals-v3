import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum'],
    title: 'Request for Bounty Payout - June 2024',
    shortName: 'RequestForBountyPayoutJune2024',
    date: '20240702',
    discussion: 'https://governance.aave.com/t/bgd-request-for-bounty-payout-june-2024/18119',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20217051}}},
};
