import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Update Ink WETH Borrow cap',
    shortName: 'UpdateInkWETHBorrowCap',
    date: '20251124',
    author: 'ACI',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {CAPS_UPDATE: [{asset: 'WETH', supplyCap: '', borrowCap: '20000'}]},
      cache: {blockNumber: 30513725},
    },
  },
};
