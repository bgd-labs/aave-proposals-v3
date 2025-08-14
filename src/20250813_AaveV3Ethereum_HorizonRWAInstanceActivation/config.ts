import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Horizon RWA Instance Activation',
    shortName: 'HorizonRWAInstanceActivation',
    date: '20250813',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-horizon-s-rwa-instance/21898',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xc69410600084e9d3d27e6569dddda08fc053182bcf402e3e612fc97cab783f24',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23133461}}},
};
