import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Safety Module stkAAVE - Re-enable Rewards',
    shortName: 'SafetyModuleStkAAVEReEnableRewards',
    date: '20241106',
    author: '@karpatkey_TokenLogic',
    discussion: '',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21128772}}},
};
