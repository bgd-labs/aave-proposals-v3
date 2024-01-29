import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum', 'AaveV3Polygon'],
    title: 'Treasury Management - GSM Funding & RWA Strategy Preparations (Part 1)',
    shortName: 'TreasuryManagementGSMFundingRWAStrategyPreparationsPart1',
    date: '20231229',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/gho-stability-module-update/14442/10',
    snapshot: '',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 18891644}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 51700277}},
  },
};
