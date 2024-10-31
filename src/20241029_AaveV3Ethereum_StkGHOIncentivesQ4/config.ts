import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'stkGHO Incentives Q4',
    shortName: 'StkGHOIncentivesQ4',
    date: '20240424',
    author: 'karpatkey_TokenLogic_ACI',
    discussion: 'https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640',
    snapshot: 'Direct-to-AIP',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19727543}}},
};
