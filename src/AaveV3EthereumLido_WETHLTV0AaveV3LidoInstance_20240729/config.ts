import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'wETH LTV0 Aave V3 Lido Instance ',
    shortName: 'WETHLTV0AaveV3LidoInstance',
    date: '20240729',
    author: 'ACI',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 20414432}}},
};
