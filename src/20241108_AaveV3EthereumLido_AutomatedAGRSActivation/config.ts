import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Automated AGRS Activation',
    shortName: 'AutomatedAGRSActivation',
    date: '20241108',
    author: 'BGD Labs (@bgdlabs)',
    discussion:
      'https://governance.aave.com/t/arfc-aave-generalized-risk-stewards-agrs-activation/19178/3',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 21142503}}},
};
