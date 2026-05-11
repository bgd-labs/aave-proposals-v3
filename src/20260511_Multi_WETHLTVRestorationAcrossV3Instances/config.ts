import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Labs',
    pools: [
      'AaveV3Ethereum',
      'AaveV3EthereumLido',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Linea',
      'AaveV3Mantle',
    ],
    title: 'WETH LTV Restoration Across V3 Instances',
    shortName: 'WETHLTVRestorationAcrossV3Instances',
    date: '20260511',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-weth-unfreeze-and-ltv-restoration-across-aave-v3-instances/24878',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25070702}},
    AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 25070702}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 461648606}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 45849591}},
    AaveV3Linea: {configs: {}, cache: {blockNumber: 30600604}},
    AaveV3Mantle: {configs: {OTHERS: {}}, cache: {blockNumber: 95179108}},
  },
};
