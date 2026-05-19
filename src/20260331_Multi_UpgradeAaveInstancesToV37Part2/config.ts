import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: [
      'AaveV3Ethereum',
      'AaveV3EthereumLido',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3BNB',
      'AaveV3Linea',
      'AaveV3Plasma',
      'AaveV3Mantle',
    ],
    title: 'Upgrade Aave instances to v3.7 Part 2',
    shortName: 'UpgradeAaveInstancesToV37Part2',
    date: '20260331',
    discussion: 'https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075',
    snapshot:
      'https://snapshot.org/#/aavedao.eth/proposal/0x2cdd27eda22b36ddde2303c3d69859f74b330eb93661e632700d18c6095335a8',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24780207}},
    AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 24780207}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 84935835}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 81779793}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 447697454}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 44101182}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 89872134}},
    AaveV3Linea: {configs: {OTHERS: {}}, cache: {blockNumber: 29997247}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 18059853}},
    AaveV3Mantle: {configs: {OTHERS: {}}, cache: {blockNumber: 93430702}},
  },
};
