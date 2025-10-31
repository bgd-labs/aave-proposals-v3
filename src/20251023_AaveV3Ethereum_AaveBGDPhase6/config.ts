import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Aave BGD Phase 6',
    shortName: 'AaveBGDPhase6',
    date: '20251023',
    author: 'BGD Labs (@bgdlabs)',
    discussion: 'https://governance.aave.com/t/arfc-aave-bored-ghosts-developing-phase-6/23191',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23639554}}},
};
