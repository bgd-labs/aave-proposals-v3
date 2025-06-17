import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum'],
    title: 'Test vote on Ethereum',
    shortName: 'TestVoteOnEthereum',
    date: '20250530',
    discussion: '',
    snapshot: '',
    votingNetwork: 'ETHEREUM',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22595989}}},
};
