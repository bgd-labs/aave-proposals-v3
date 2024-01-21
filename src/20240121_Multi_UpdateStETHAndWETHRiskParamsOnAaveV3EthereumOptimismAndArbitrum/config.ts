import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Optimism', 'AaveV3Arbitrum'],
    title: 'Update stETH and WETH Risk Params on Aave v3 Ethereum, Optimism and Arbitrum',
    shortName: 'UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum',
    date: '20240121',
    author: 'Aave Chan Initiative',
    discussion:
      'https://governance.aave.com/t/arfc-update-steth-and-weth-risk-params-on-aave-v3-ethereum-optimism-and-arbitrum/16168',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xb8790aeb32267062c1500deb613ad15ebd5deac4d78d1786cb1690c12d0512c9',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '',
            priceSource: '',
            label: '',
          },
        ],
      },
      cache: {blockNumber: 19057854},
    },
    AaveV3Optimism: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3OptimismEModes.ETH_CORRELATED',
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '',
            priceSource: '',
            label: '',
          },
        ],
      },
      cache: {blockNumber: 115136904},
    },
    AaveV3Arbitrum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3ArbitrumEModes.ETH_CORRELATED',
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '1',
            priceSource: '',
            label: '',
          },
        ],
      },
      cache: {blockNumber: 172805315},
    },
  },
};
