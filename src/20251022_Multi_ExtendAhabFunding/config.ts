import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Plasma'],
    title: 'Extend Ahab Funding',
    shortName: 'ExtendAhabFunding',
    date: '20251022',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-extend-ahab-funding/23213/2',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xa1cb3c88f8c30a05dca3c767a60abc31b4f48fe36a4175f421ac0f2e8ab7dbac',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23635048}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 4230876}},
  },
};
