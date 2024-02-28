import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Treasury Management - GSM Funding & RWA Strategy Preparations (Part 2)',
    shortName: 'TreasuryManagementGSMFundingRWAStrategyPreparationsPart2',
    date: '20240209',
    author: 'karpatkey_TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-treasury-management-gsm-funding-rwa-strategy-preparations/16128',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xb39537e468eef8c212c67a539cdc6d802cd857f186a4f66aefd44faaadd6ba19',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19191027}}},
};
