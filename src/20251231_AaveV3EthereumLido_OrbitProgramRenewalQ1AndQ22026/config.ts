import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Iniiative',
    pools: ['AaveV3EthereumLido'],
    title: 'Orbit Program Renewal - Q1 and Q2 2026',
    shortName: 'OrbitProgramRenewalQ1AndQ22026',
    date: '20251231',
    discussion: 'https://governance.aave.com/t/arfc-orbit-program-renewal-q1-and-q2-2026/23695',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0xdd35aa587c490548ce8ebc6293231718e68d53ded7704f576fd07bcaabe722a8',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 24134407}}},
};
