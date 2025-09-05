import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV2Ethereum', 'AaveV2EthereumAMM', 'AaveV2Polygon', 'AaveV2Avalanche'],
    title: 'Aave V2 deprecation',
    shortName: 'AaveV2Deprecation',
    date: '20250904',
    discussion: 'https://governance.aave.com/t/arfc-aave-v2-deprecation-tech-next-phase/23022',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23289614}},
    AaveV2EthereumAMM: {configs: {OTHERS: {}}, cache: {blockNumber: 23289614}},
    AaveV2Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 76042057}},
    AaveV2Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 68172961}},
  },
};
