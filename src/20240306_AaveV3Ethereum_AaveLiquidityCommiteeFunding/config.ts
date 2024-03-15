import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Aave Liquidity Commitee Funding',
    shortName: 'ALCFunding',
    date: '20240306',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-aave-liquidity-committee-funding/16793',
    snapshot: '',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19376619}},
  },
};
