import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'April Finance Update Part B',
    shortName: 'AprilFinanceUpdatePartB',
    date: '20240515',
    author: '@karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-april-finance-update/17390',
    snapshot: 'Direct-to-AIP',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19879169}}},
};
