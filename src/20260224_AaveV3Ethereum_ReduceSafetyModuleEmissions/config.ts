import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Reduce Safety Module Emissions',
    shortName: 'ReduceSafetyModuleEmissions',
    date: '20260224',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-safety-module-reduce-emissions/24203',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xe76461b0936fc892904c1696066b9fa3688e1042078d9c9f06c1a937736a100e',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24528301}}},
};
