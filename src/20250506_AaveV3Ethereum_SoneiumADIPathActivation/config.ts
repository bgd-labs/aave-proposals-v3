import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum'],
    title: 'Soneium aDI path activation',
    shortName: 'SoneiumADIPathActivation',
    date: '20250506',
    discussion: '',
    snapshot: '',
    votingNetwork: 'ETHEREUM',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22424729}}},
};
