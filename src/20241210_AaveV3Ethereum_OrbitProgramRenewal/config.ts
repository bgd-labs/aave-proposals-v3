import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Orbit Program Renewal',
    shortName: 'OrbitProgramRenewal',
    date: '20241210',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-orbit-program-renewal-q4-2024/20084',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x60613deb2c662057cc8028b431df84fe6e763d38f48f70594a7cb7fd91a8cb93',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 21371374}}},
};
