import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'GHO Stability Module',
    shortName: 'GHOStabilityModule',
    date: '20240119',
    author: 'Aave Labs @aave',
    discussion: 'https://governance.aave.com/t/gho-stability-module-update/14442',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xe9b62e197a98832da7d1231442b5960588747f184415fba4699b6325d7618842',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19037596}}},
};
