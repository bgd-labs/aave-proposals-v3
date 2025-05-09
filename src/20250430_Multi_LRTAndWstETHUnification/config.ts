import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido', 'AaveV3Arbitrum', 'AaveV3Base'],
    title: 'LRT and wstETH Unification',
    shortName: 'LRTAndWstETHUnification',
    date: '20250430',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-lrt-and-wsteth-unification/21739',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22377625}},
    AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 22377625}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 331579415}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 29587769}},
  },
};
