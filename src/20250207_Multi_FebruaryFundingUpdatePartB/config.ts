import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Optimism', 'AaveV3Arbitrum'],
    title: 'February Funding Update - Part B',
    shortName: 'FebruaryFundingUpdatePartB',
    date: '20250207',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-february-funding-update/20712',
    snapshot: 'Direct-To-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {}, cache: {blockNumber: 21937771}},
    AaveV3Polygon: {configs: {}, cache: {blockNumber: 68436258}},
    AaveV3Optimism: {configs: {}, cache: {blockNumber: 132531064}},
    AaveV3Arbitrum: {configs: {}, cache: {blockNumber: 310439056}},
  },
};
