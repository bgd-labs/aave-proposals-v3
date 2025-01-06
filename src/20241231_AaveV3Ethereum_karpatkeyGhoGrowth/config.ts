import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'karpatkey Gho Growth Service Provider',
    shortName: 'karpatkeyGhoGrowthServiceProvider',
    date: '20241231',
    author: 'karpatkey',
    discussion:
      ' https://governance.aave.com/t/arfc-karpatkey-as-gho-growth-service-provider/20206',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x87585d9dcb104d2946ca2def6bcf57708480fafc5e310de4850dc2fbe1820893',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 21524445}}},
};
