import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'stkAAVE + stkBPT Emissions',
    shortName: 'StkAAVEStkBPTEmissions',
    date: '20250903',
    author: '@TokenLogic',
    discussion: '',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 23284660}}},
};
