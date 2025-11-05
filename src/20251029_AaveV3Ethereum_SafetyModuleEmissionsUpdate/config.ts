import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Safety Module Emissions Update',
    shortName: 'SafetyModuleEmissionsUpdate',
    date: '20251029',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/26',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23682983}}},
};
