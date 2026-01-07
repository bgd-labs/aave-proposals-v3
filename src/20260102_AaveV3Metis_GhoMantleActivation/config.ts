import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Mantle'],
    title: 'Gho Mantle Activation',
    shortName: 'GhoMantleActivation',
    date: '20260102',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-deploy-aave-v3-on-mantle/20542/10',
    snapshot: 'TODO',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Mantle: {configs: {OTHERS: {}}, cache: {blockNumber: 21902963}}},
};
