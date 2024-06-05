import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Gho Steward Update',
    shortName: 'GhoStewardUpdate',
    date: '20240602',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-gho-stewards/16466/11',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20002947}}},
};
