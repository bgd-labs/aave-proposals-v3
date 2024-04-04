import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Polygon'],
    title: 'ReserveFactorUpdates',
    shortName: 'ReserveFactorUpdates',
    date: '20240322',
    author: 'TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/21',
    snapshot: '',
  },
  poolOptions: {AaveV2Polygon: {configs: {}, cache: {blockNumber: 55391331}}},
};
