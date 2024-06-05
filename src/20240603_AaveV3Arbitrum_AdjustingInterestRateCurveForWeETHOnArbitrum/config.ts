import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum'],
    title: ' Adjusting Interest Rate Curve for weETH on Arbitrum',
    shortName: 'AdjustingInterestRateCurveForWeETHOnArbitrum',
    date: '20240603',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-adjusting-interest-rate-curve-for-weeth-on-arbitrum/17804',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xed2fd3dfee1f29f04b6cda4a5c4629fcca32a5c961b1b3e2a49ba6842367ce31',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Arbitrum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'weETH',
            params: {
              optimalUtilizationRate: '35',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
              stableRateSlope1: '7',
              stableRateSlope2: '300',
              baseStableRateOffset: '0',
              stableRateExcessOffset: '00',
              optimalStableToTotalDebtRatio: '0',
            },
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '45',
            asset: 'weETH',
          },
        ],
      },
      cache: {blockNumber: 217920822},
    },
  },
};
