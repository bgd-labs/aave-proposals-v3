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
      'https://snapshot.org/#/s:aavedao.eth/proposal/0x2f9378770f1838f0ea8d483239af1530c9fbea98d648e0b11e4647dcb722d119',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Mantle: {configs: {OTHERS: {}}, cache: {blockNumber: 90136862}}},
};
