import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Safety Module Emission Update',
    shortName: 'SafetyModuleEmissionUpdate',
    date: '20250721',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-safety-module-emission-update/22554',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x844e6490591165e166fe511c1c527798369a21394fd93812d299cc320ec91dd5',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22967726}}},
};
