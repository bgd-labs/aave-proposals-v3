import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'GHOBorrowRateIncrease',
    shortName: 'GHOBorrowRateIncrease',
    date: '20240308',
    discussion: 'https://governance.aave.com/t/arfc-increase-gho-borrow-rate-08-03-2024/16885',
    snapshot: 'No snapshot for Direct-to-AIP',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19391086}}},
};
