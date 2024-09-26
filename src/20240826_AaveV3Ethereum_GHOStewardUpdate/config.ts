import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'GHO Steward Update',
    shortName: 'GHOStewardUpdate',
    date: '20240826',
    author: 'BGD Labs (@bgdlabs)',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20611314}}},
};
