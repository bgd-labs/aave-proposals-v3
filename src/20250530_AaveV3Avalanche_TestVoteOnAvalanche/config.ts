import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Avalanche'],
    title: 'Test vote on Avalanche',
    shortName: 'TestVoteOnAvalanche',
    date: '20250530',
    discussion: '',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 63005641}}},
};
