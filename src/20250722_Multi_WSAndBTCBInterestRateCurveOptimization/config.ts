import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Avalanche', 'AaveV3Sonic'],
    title: 'wS and BTC.b Interest Rate Curve Optimization',
    shortName: 'WSAndBTCBInterestRateCurveOptimization',
    date: '20250722',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-ws-and-btc-b-interest-rate-curve-optimization/21962',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Avalanche: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'BTCb',
            params: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '',
              variableRateSlope1: '4',
              variableRateSlope2: '80',
            },
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '50',
            asset: 'BTCb',
          },
        ],
      },
      cache: {blockNumber: 65900467},
    },
    AaveV3Sonic: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'wS',
            params: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '',
              variableRateSlope1: '4',
              variableRateSlope2: '80',
            },
          },
        ],
      },
      cache: {blockNumber: 39723500},
    },
  },
};
