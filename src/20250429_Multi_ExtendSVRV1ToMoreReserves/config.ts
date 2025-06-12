import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido'],
    title: 'Extend SVR V1 to more reserves',
    shortName: 'ExtendSVRV1ToMoreReserves',
    date: '20250429',
    discussion: 'https://governance.aave.com/t/arfc-aave-chainlink-svr-v1-phase-1-activation/21247',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22374621}},
    AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 22374622}},
  },
};
