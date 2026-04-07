import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Aave Will Win Framework: Primary Funding Request',
    shortName: 'AaveWillWinFrameworkPrimaryFundingRequest',
    date: '20260407',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-aave-will-win-framework/24352',
    snapshot:
      'https://snapshot.org/#/aavedao.eth/proposal/0x35901c1a7cd2baf56dfd120024793b30dd73c52e1c0a9810ff78efbca3b5fbcb',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 24828043}}},
};
