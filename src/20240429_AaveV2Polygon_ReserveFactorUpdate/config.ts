import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Polygon'],
    title: 'ReserveFactorUpdate',
    shortName: 'ReserveFactorUpdate',
    date: '20240429',
    author: 'TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/23?u=dd0sxx',
    snapshot: '',
  },
  poolOptions: {AaveV2Polygon: {configs: {}, cache: {blockNumber: 56380847}}},
};
