import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Gnosis',
      'AaveV3Sonic',
    ],
    title: 'September Funding Update',
    shortName: 'SeptemberFundingUpdate',
    date: '20250826',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/direct-to-aip-september-2025-funding-update/22915',
    snapshot: 'Todo',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23228445}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 75695832}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 67696205}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 140325310}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 372840280}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 41807866}},
    AaveV3Sonic: {configs: {OTHERS: {}}, cache: {blockNumber: 44661617}},
  },
};
