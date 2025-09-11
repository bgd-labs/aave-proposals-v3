import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
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
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23283990}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 76010580}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 140660410}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 375324010}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 41807866}},
    AaveV3Sonic: {configs: {OTHERS: {}}, cache: {blockNumber: 44661617}},
  },
};
