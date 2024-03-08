import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Amend Safety Module Emissions',
    shortName: 'AmendSafetyModuleEmissions',
    date: '20240229',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x0f73500d0f65c72482d352080ea9aa0aa92264eb059b8f646cf6f0e86556bc3d',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19334472}}},
};
