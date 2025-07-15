import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3BNB',
    ],
    title: 'Aave Robot Maintenance',
    shortName: 'AaveRobotMaintenance',
    date: '20250330',
    author: 'BGD Labs (@bgdlabs)',
    discussion: 'https://governance.aave.com/t/technical-maintenance-proposals/15274/96',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22160683}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 69689324}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 59474322}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 133875255}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 321158457}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 28279971}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 47922506}},
  },
};
