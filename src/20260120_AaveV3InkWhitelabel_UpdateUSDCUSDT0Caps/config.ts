import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Update USDC & USDT0 caps',
    shortName: 'UpdateUSDCUSDT0Caps',
    date: '20260120',
    author: 'ACI',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {
        CAPS_UPDATE: [
          {asset: 'USDT', supplyCap: '375000000', borrowCap: '340000000'},
          {asset: 'USDC', supplyCap: '250000000', borrowCap: '225000000'},
        ],
      },
      cache: {blockNumber: 35414297},
    },
  },
};
