import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Updating weETH Risk Parameters',
    shortName: 'UpdatingWeETHRiskParameters',
    date: '20240426',
    discussion: 'https://governance.aave.com/t/arfc-updating-weeth-risk-parameters/17402',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xf01d857c392a5d3efcd69725cdee5a5d8e94e5cbe952791d24ff26a26f2b83fa',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'weETH',
            params: {
              optimalUtilizationRate: '35',
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
        CAPS_UPDATE: [{asset: 'weETH', supplyCap: '84000', borrowCap: '29500'}],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '45',
            asset: 'weETH',
          },
        ],
      },
      cache: {blockNumber: 19735235},
    },
  },
};
