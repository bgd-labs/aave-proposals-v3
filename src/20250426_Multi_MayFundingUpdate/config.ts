import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Optimism', 'AaveV3Arbitrum', 'AaveV3Gnosis'],
    title: 'May Funding Update',
    shortName: 'MayFundingUpdate',
    date: '20250426',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-may-2025-funding-update/21906',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22369914}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 70871207}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 135164971}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 331207896}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 39797083}},
  },
};
