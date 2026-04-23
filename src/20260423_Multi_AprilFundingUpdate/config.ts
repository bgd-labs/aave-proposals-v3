import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Avalanche',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Scroll',
      'AaveV3Linea',
      'AaveV3Plasma',
    ],
    title: 'April Funding Update',
    shortName: 'AprilFundingUpdate',
    date: '20260423',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/direct-to-aip-april-2026-funding-update/24447',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24944785}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 83705636}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 455608521}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 45091872}},
    AaveV3Scroll: {configs: {OTHERS: {}}, cache: {blockNumber: 33459607}},
    AaveV3Linea: {configs: {OTHERS: {}}, cache: {blockNumber: 30352670}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 20041232}},
  },
};
