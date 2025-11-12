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
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23770613}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 78847011}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 143600066}},
    AaveV3Metis: {configs: {OTHERS: {}}, cache: {blockNumber: 21606204}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 67730544}},
    AaveV3Sonic: {configs: {OTHERS: {}}, cache: {blockNumber: 54766988}},
  },
};
