import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Update caps + slope',
    shortName: 'UpdateCapsSlope',
    date: '20251216',
    author: 'ACI',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.5',
              variableRateSlope2: '',
            },
          },
        ],
        CAPS_UPDATE: [
          {asset: 'GHO', supplyCap: '40000000', borrowCap: '36000000'},
          {asset: 'USDC', supplyCap: '40000000', borrowCap: '38000000'},
          {asset: 'ezETH', supplyCap: '36000', borrowCap: ''},
        ],
      },
      cache: {blockNumber: 32390733},
    },
  },
};
