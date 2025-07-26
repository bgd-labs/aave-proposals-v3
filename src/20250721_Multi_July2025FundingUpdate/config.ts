import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Arbitrum', 'AaveV3Gnosis'],
    title: 'July 2025 - Funding Update',
    shortName: 'July2025FundingUpdate',
    date: '20250721',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/direct-to-aip-july-2025-funding-update/22555',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22983575}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 74320500}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 360806785}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 41201011}},
  },
};
