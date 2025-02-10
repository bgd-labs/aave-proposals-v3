import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Request for Bounty Payout - Feb 2025',
    shortName: 'RequestForBountyPayoutFeb2025',
    date: '20250203',
    author: 'BGD Labs (@bgdlabs)',
    discussion: '',
    snapshot: 'Direct To AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21765193}}},
};
