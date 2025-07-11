import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Sonic'],
    title: 'stS Loop Incentive Program',
    shortName: 'StSLoopIncentiveProgram',
    date: '20250711',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-sts-loop-incentive-program/22368',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x65e12ce7784f12fbed9731d4cdbc826a8a5d4804439dc6d55d6e31c0b069a048',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Sonic: {configs: {OTHERS: {}}, cache: {blockNumber: 38053079}}},
};
