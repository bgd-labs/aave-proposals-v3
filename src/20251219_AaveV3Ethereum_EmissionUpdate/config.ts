import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Umbrella Emission Update',
    shortName: 'EmissionUpdate',
    date: '20251219',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24044429}}},
};
