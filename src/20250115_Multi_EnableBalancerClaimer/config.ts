import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido', 'AaveV3Gnosis'],
    title: 'Enable balancer claimer',
    shortName: 'EnableBalancerClaimer',
    date: '20250115',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21632595}},
    AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 21632595}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 38060179}},
  },
};
