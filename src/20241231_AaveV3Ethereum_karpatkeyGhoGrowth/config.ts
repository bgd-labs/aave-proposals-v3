import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'rpatkey Gho Growth Service Provider',
    shortName: 'karpatkeyGhoGrowthServiceProvider',
    date: '20241231',
    author: 'karpatkey',
    discussion: 'https://governance.aave.com/t/arfc-tokenlogic-financial-services-provider/20182',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0xd1fdca5d69b03ed57848180d62a812ab1a1ff72f85d671c417b5ff8fb2bd0a7c',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 21524445}}},
};
