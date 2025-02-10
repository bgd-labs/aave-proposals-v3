import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV2Ethereum',
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
    ],
    title: 'February Funding Update',
    shortName: 'FebruaryFundingUpdate',
    date: '20250120',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-february-funding-update/20712',
    snapshot: 'Direct-To-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21667725}},
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21667725}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 66938521}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 130900857}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 297496675}},
  },
};
