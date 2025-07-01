import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'CEX Earn Funding Proposal',
    shortName: 'CEXEarnFundingProposal',
    date: '20250625',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-gho-cex-earn-incentive-program/22284',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xa390fb9061fd689a5d93519a7a9dae23d76b4010b3eea6aaedc70ea7aaed9310',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 22796230}}},
};
