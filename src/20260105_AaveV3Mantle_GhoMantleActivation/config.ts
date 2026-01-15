import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Mantle'],
    title: 'Gho Mantle Activation',
    shortName: 'GhoMantleActivation',
    date: '20260105',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-deploy-aave-v3-on-mantle/20542/10',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xa3dc5b82f2dc5176c2a7543a6cc10aa75cccf96a73afe06478795182cff9d771',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Mantle: {configs: {OTHERS: {}}, cache: {blockNumber: 90136862}}},
};
