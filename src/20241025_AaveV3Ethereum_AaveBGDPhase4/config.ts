import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Aave BGD Phase 4',
    shortName: 'AaveBGDPhase4',
    date: '20241025',
    author: 'BGD Labs (@bgdlabs)',
    discussion: 'https://governance.aave.com/t/aave-bored-ghosts-developing-phase-4/19484',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x2dfb5a6e770bf7a34ddb5ab05560c24a169c63f84e9e8d373767a5b072f1f21d',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21043153}}},
};
