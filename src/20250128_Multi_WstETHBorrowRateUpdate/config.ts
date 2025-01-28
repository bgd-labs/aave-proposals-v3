import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum', 'AaveV3Base', 'AaveV3Scroll', 'AaveV3ZkSync'],
    title: 'wstETH Borrow Rate Update',
    shortName: 'WstETHBorrowRateUpdate',
    date: '20250128',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-wsteth-borrow-rate-update/20762',
    snapshot:
      'https://snapshot.org/#/s:aave.eth/proposal/0xcb271a2308f78eeab5cbf5576938b61e7437c99781320c1340c885a656c9dbdc',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Arbitrum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'wstETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '0.75',
              variableRateSlope2: '85',
            },
          },
        ],
      },
      cache: {blockNumber: 300154330},
    },
    AaveV3Base: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'wstETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '0.75',
              variableRateSlope2: '85',
            },
          },
        ],
      },
      cache: {blockNumber: 25638941},
    },
    AaveV3Scroll: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'wstETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '0.75',
              variableRateSlope2: '85',
            },
          },
        ],
      },
      cache: {blockNumber: 13028907},
    },
    AaveV3ZkSync: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'wstETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '0.75',
              variableRateSlope2: '85',
            },
          },
        ],
      },
      cache: {blockNumber: 54743911},
    },
  },
};
