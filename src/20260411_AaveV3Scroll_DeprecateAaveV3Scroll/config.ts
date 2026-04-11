import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Labs',
    pools: ['AaveV3Scroll'],
    title: 'DeprecateAaveV3Scroll',
    shortName: 'DeprecateAaveV3Scroll',
    date: '20260411',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-aave-v3-scroll-instance-deprecation/24432',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Scroll: {configs: {}, cache: {blockNumber: 33271801}}},
};
