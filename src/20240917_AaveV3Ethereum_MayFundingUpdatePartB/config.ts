import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'May Funding Update Part B',
    shortName: 'MayFundingUpdatePartB',
    date: '20240917',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-may-funding-update/17768/5',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20766625}}},
};
