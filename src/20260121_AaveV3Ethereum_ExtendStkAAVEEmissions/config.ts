import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Extend stkAAVE Emissions',
    shortName: 'ExtendStkAAVEEmissions',
    date: '20260121',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/49',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x0f73500d0f65c72482d352080ea9aa0aa92264eb059b8f646cf6f0e86556bc3d',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24284203}}},
};
