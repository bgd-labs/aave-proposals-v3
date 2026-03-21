import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum'],
    title: 'MegaEth aDI path activation',
    shortName: 'MegaEthADIPathActivation',
    date: '20260115',
    discussion: '',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24239684}}},
};
