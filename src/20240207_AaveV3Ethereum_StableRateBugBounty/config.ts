import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Stable Rate Bug Bounty',
    shortName: 'StableRateBugBounty',
    date: '20240207',
    author: 'BGD Labs @bgdlabs',
    discussion: 'https://governance.aave.com/t/bgd-full-deprecation-of-stable-rate/16473',
    snapshot: '',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19174640}}},
};
