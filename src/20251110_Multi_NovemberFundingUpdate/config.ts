import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Optimism',
      'AaveV3Metis',
      'AaveV3BNB',
      'AaveV3Sonic',
    ],
    title: 'November Funding Update',
    shortName: 'NovemberFundingUpdate',
    date: '20251110',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/direct-to-aip-november-2025-funding-update/23339',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23820685}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 79154342}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 143902770}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 68537855}},
    AaveV3Sonic: {configs: {OTHERS: {}}, cache: {blockNumber: 55579780}},
  },
};
