import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Security Budget Request December 2023',
    shortName: 'SecurityBudgetRequestDecember2023',
    date: '20240206',
    author: 'BGD Labs @bgdlabs',
    discussion:
      'https://governance.aave.com/t/arfc-bgd-security-budget-request-december-2023/15783',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xf95bc210e3e93c2112c694cb158db22c93504155b48c03d9358e4c41c33ee782',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19167318}}},
};
