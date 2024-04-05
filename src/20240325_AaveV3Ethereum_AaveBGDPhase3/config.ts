import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Aave BGD Phase 3',
    shortName: 'AaveBGDPhase3',
    date: '20240325',
    author: 'BGD Labs',
    discussion: 'https://governance.aave.com/t/aave-bored-ghosts-developing-phase-2',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xf453667458e093dcd5bd986e0a62b4ef9dc914dca56ef97a8dc28ca89af6c8d3',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19511164}}},
};
