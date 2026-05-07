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
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25044803}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 86535455}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 84842911}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 46056118}},
    AaveV3Linea: {configs: {OTHERS: {}}, cache: {blockNumber: 30547773}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 21244905}},
    AaveV3Mantle: {configs: {}, cache: {blockNumber: 95023228}},
  },
};
