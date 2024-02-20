import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Polygon'],
    title: 'MaticX Supply Cap Increase in Polygon V3',
    shortName: 'MaticXSupplyCapIncreaseInPolygonV3',
    date: '20240206',
    author: 'Aave Chan Initiative (ACI)',
    discussion: 'https://governance.aave.com/t/arfc-maticx-supply-cap-increase-in-polygon-v3/16449',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x73b2f1d14eb6710deabe84639ea8b06929738ef1973fee21c26945d17bf57a5b',
  },
  poolOptions: {
    AaveV3Polygon: {
      configs: {CAPS_UPDATE: [{asset: 'MaticX', supplyCap: '75000000', borrowCap: ''}]},
      cache: {blockNumber: 53201815},
    },
  },
};
