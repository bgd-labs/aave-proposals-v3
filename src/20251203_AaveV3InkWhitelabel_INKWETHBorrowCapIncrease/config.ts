import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'INK wETH borrow cap increase',
    shortName: 'INKWETHBorrowCapIncrease',
    date: '20251203',
    author: 'Chaos Labs (implemented by ACI via Skyward)',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {CAPS_UPDATE: [{asset: 'WETH', supplyCap: '', borrowCap: '70000'}]},
      cache: {blockNumber: 31234261},
    },
  },
};
