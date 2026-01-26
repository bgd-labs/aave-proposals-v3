import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Update KBTC Ink caps',
    shortName: 'UpdateKBTCInkCaps',
    date: '20251231',
    author: 'ACI',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {CAPS_UPDATE: [{asset: 'kBTC', supplyCap: '2750', borrowCap: ''}]},
      cache: {blockNumber: 33713218},
    },
  },
};
