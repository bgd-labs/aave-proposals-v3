import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Optimism', 'AaveV3Arbitrum'],
    title: 'September Funding Update - Part A',
    shortName: 'SeptemberFundingUpdatePartA',
    date: '20241113',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-september-funding-update/19162',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {}, cache: {blockNumber: 21179000}},
    AaveV3Polygon: {configs: {}, cache: {blockNumber: 64236044}},
    AaveV3Optimism: {configs: {}, cache: {blockNumber: 127952448}},
    AaveV3Arbitrum: {configs: {}, cache: {blockNumber: 274046247}},
  },
};
