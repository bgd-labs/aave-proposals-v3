import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Emission Update',
    shortName: 'EmissionUpdate',
    date: '20251219',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-safety-module-umbrella-emission-update/23103/9',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x6712b1677068d2d316af699757057a0c8c03e0ff0693c12aacc381d294c419a4',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24044429}}},
};
