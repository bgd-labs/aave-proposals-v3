import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido'],
    title: 'Aave BGD Phase 5',
    shortName: 'AaveBGDPhase5',
    date: '20250426',
    author: 'BGD Labs (@bgdlabs)',
    discussion: 'https://governance.aave.com/t/arfc-aave-bored-ghosts-developing-phase-5/21803',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xcad607fa0b4cc00eb09d8af5a6506d64b74a0713b4261014ca3f23fa8afe4c07',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22351541}},
    AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 22351542}},
  },
};
