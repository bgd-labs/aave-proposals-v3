import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3EthereumLido',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Gnosis',
      'AaveV3Linea',
      'AaveV3Plasma',
      'AaveV3Mantle',
    ],
    title: 'CAPO SnapshotRatio Update Across Aave V3',
    shortName: 'CAPOSnapshotRatioUpdateAcrossAaveV3',
    date: '20260507',
    author: 'Llama Risk (implemented by Aave Labs)',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-capo-snapshotratio-update-across-aave-v3/24854',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25127618}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 87105250}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 85814183}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 46250763}},
    AaveV3Linea: {configs: {OTHERS: {}}, cache: {blockNumber: 30700219}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 22242033}},
    AaveV3Mantle: {configs: {}, cache: {blockNumber: 95521792}},
  },
};
