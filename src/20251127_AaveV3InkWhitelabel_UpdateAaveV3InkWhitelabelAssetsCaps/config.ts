import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Update AaveV3InkWhitelabel assets caps',
    shortName: 'UpdateAaveV3InkWhitelabelAssetsCaps',
    date: '20251127',
    author: 'ACI',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {
        CAPS_UPDATE: [
          {asset: 'WETH', supplyCap: '80000', borrowCap: ''},
          {asset: 'GHO', supplyCap: '20000000', borrowCap: '18000000'},
          {asset: 'USDC', supplyCap: '20000000', borrowCap: '19000000'},
        ],
      },
      cache: {blockNumber: 30755047},
    },
  },
};
