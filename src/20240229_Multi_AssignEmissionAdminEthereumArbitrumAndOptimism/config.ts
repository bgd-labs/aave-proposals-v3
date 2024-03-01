import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Optimism', 'AaveV3Arbitrum'],
    title: 'Assign Emission Admin - Ethereum, Arbitrum and Optimism',
    shortName: 'AssignEmissionAdminEthereumArbitrumAndOptimism',
    date: '20240229',
    author: 'karpatkey-TokenLogic & ACI',
    discussion: 'TODO',
    snapshot: 'TODO',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19335100}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 116817141}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 185767002}},
  },
};
