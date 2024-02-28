import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Cut Gauntlet Service Provider Stream',
    shortName: 'CutGauntletServiceProviderStream',
    date: '20240227',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/gauntlet-is-leaving-aave/16700',
    snapshot: 'Direct-to-AIP',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19319345}}},
};
