import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV2Polygon',
      'AaveV2Avalanche',
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
    ],
    title: 'Migrate Robots to Chainlink Automation v2',
    shortName: 'MigrateRobotsToChainlinkAutomationV2',
    date: '20240422',
    author: 'BGD Labs (@bgdlabs)',
    discussion: '',
    snapshot: '',
  },
  poolOptions: {
    AaveV2Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 56113527}},
    AaveV2Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 44512836}},
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19709151}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 56113531}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 44512842}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 119084285}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 203571065}},
  },
};
