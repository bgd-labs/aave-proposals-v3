import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'stkAAVE Emissions',
    shortName: 'StkAAVEEmissions',
    date: '20250520',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/26',
    snapshot: 'Direct-To-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22523454}}},
};
