import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Orbit Renewal',
    shortName: 'OrbitRenewal',
    date: '20251103',
    author: 'ACI',
    discussion:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0x4f2381126a2ddf4073916bbdd6d25b031c2dabd022d23887cee6f315693fd7c4',
    snapshot: 'https://governance.aave.com/t/arfc-orbit-program-renewal-q3-and-q4-2025/23289',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 23719647}}},
};
