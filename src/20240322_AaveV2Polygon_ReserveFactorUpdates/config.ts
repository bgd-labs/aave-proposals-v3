import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Polygon'],
    title: 'ReserveFactorUpdates',
    shortName: 'ReserveFactorUpdates',
    date: '20240322',
    author: 'TokenLogic',
    discussion: 'https://hackmd.io/VuOFSRuzSXOb0vNxP5-Otw',
    snapshot: '',
  },
  poolOptions: {AaveV2Polygon: {configs: {}, cache: {blockNumber: 54963727}}},
};
