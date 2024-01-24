import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum'],
    title: 'Register a.DI Scroll adapter',
    shortName: 'RegisterADIScrollAdapter',
    date: '20240122',
    discussion: '',
    snapshot: '',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19062723}}},
};
