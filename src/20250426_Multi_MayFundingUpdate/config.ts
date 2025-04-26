import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Optimism', 'AaveV3Arbitrum'],
    title: 'May Funding Update',
    shortName: 'MayFundingUpdate',
    date: '20250426',
    author: 'TokenLogic',
    discussion: 'TODO',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22349707}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 70757043}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 135014789}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 330240450}},
  },
};
