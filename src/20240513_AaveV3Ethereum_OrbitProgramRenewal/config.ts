import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Orbit Program Renewal',
    shortName: 'OrbitProgramRenewal',
    date: '20240513',
    discussion: 'https://governance.aave.com/t/arfc-orbit-program-renewal-may-2024/17683',
    snapshot: 'TODO',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19862601}}},
};
