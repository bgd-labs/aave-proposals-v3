import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV2Ethereum', 'AaveV2EthereumAMM', 'AaveV2Polygon', 'AaveV2Avalanche'],
    title: 'Aave V2 deprecation',
    shortName: 'AaveV2Deprecation',
    date: '20250813',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23132688}},
    AaveV2EthereumAMM: {configs: {OTHERS: {}}, cache: {blockNumber: 23132688}},
    AaveV2Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 75157411}},
    AaveV2Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 67011241}},
  },
};
