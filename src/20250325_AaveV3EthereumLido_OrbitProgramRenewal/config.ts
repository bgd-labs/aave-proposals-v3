import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3EthereumLido'],
    title: 'Orbit Program Renewal',
    shortName: 'OrbitProgramRenewal',
    date: '20250325',
    discussion: 'https://governance.aave.com/t/arfc-orbit-program-renewal-q1-2025/21205',
    snapshot: 'https://governance.aave.com/t/arfc-orbit-program-renewal-q1-2025/21205',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 22124480}}},
};
