import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Llamarisk Risk Provider',
    shortName: 'LlamariskRiskProvider',
    date: '20240421',
    discussion: 'https://governance.aave.com/t/arfc-onboard-new-risk-service-provider/17348',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x2b7433455b16d50b9b6afdf2e60bfd6e733896224688c9891c371aa2597853a2',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19705748}}},
};
