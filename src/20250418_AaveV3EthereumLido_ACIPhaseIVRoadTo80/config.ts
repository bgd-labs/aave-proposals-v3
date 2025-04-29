import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3EthereumLido'],
    title: 'ACI Phase IV – “Road to 80”',
    shortName: 'ACIPhaseIVRoadTo80',
    date: '20250418',
    discussion: 'https://governance.aave.com/t/arfc-aci-phase-iv-road-to-80/21830',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 22294313}}},
};
