import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Post Activation Risk Update',
    shortName: 'PostActivationRiskUpdate',
    date: '20251013',
    author: 'BGD Labs (@bgdlabs)',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {
        CAPS_UPDATE: [
          {asset: 'WETH', supplyCap: '40000', borrowCap: '10000'},
          {asset: 'kBTC', supplyCap: '1500', borrowCap: '200'},
          {asset: 'USDT', supplyCap: '250000000', borrowCap: '220000000'},
          {asset: 'USDG', supplyCap: '50000000', borrowCap: '40000000'},
        ],
        COLLATERALS_UPDATE: [
          {
            asset: 'USDT',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '4.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'ENABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '',
            asset: 'USDT',
          },
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'ENABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '',
            asset: 'USDG',
          },
        ],
      },
      cache: {blockNumber: 26846519},
    },
  },
};
