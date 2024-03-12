import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Optimism', 'AaveV3Arbitrum'],
    title: 'Update WETH IR on V3 Arbitrum and Optimism',
    shortName: 'UpdateWETHIROnV3ArbitrumAndOptimism',
    date: '20240216',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-update-weth-ir-on-v3-arbitrum-and-optimism-02-16-2024/16644',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xef56befdec2abf0bc9611f033c2cec62447f148369a075829664f2de6bc0ae77',
  },
  poolOptions: {
    AaveV3Optimism: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '3',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 116936293},
    },
    AaveV3Arbitrum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '3',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 186689064},
    },
  },
};
