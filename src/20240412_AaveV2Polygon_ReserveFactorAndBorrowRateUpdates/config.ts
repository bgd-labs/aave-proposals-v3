import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Polygon'],
    title: 'Polygon V2 Reserve Factor Updates & Interest Rate Increases',
    shortName: 'ReserveFactor&BorrowRateUpdates',
    date: '20240412',
    author: 'TokenLogic & Karpatkey',
    discussion:
      //'https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/22'
      'https://governance.aave.com/t/arfc-polygon-v2-borrow-rate-adjustments/17252',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x95643085ee16eb0eaa4110a9f0ea8223009f9521e596e1a958303705a5001363',
  },
  poolOptions: {
    AaveV2Polygon: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'BAL',
            params: {
              optimalUtilizationRate: '20',
              baseVariableBorrowRate: '',
              variableRateSlope1: '50',
              variableRateSlope2: '134',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'CRV',
            params: {
              optimalUtilizationRate: '10',
              baseVariableBorrowRate: '',
              variableRateSlope1: '50',
              variableRateSlope2: '134',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'GHST',
            params: {
              optimalUtilizationRate: '10',
              baseVariableBorrowRate: '',
              variableRateSlope1: '50',
              variableRateSlope2: '134',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'LINK',
            params: {
              optimalUtilizationRate: '10',
              baseVariableBorrowRate: '',
              variableRateSlope1: '50',
              variableRateSlope2: '134',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.75',
              variableRateSlope2: '134',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.75',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.75',
              variableRateSlope2: '134',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WBTC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '4.75',
              variableRateSlope2: '134',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '4.75',
              variableRateSlope2: '134',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WMATIC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.75',
              variableRateSlope2: '134',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 56422116},
    },
  },
};
