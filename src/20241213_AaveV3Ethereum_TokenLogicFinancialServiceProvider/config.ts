import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'TokenLogic Financial Service Provider',
    shortName: 'TokenLogicFinancialServiceProvider',
    date: '20241213',
    author: 'TokenLogic',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 21395370}}},
};
