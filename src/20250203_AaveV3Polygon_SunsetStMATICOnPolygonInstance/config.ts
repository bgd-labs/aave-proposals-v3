import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Polygon'],
    title: 'Sunset stMATIC on Polygon instance',
    shortName: 'SunsetStMATICOnPolygonInstance',
    date: '20250203',
    discussion: 'https://governance.aave.com/t/arfc-sunset-stmatic-on-polygon-instance/20668',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0xae420f7c844f2ef26dd74a1ed1b4b197aad5b15a8b9c1795a0c205025988fd66',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Polygon: {
      configs: {FREEZE: [{asset: 'stMATIC', shouldBeFrozen: true}]},
      cache: {blockNumber: 67495887},
    },
  },
};
