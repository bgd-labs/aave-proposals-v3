import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Labs',
    pools: ['AaveV3Ethereum', 'AaveV3Plasma'],
    title: '',
    shortName: 'ChaosAgentHubOffboarding',
    date: '20260505',
    discussion:
      'https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25041964}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 21142710}},
  },
};
