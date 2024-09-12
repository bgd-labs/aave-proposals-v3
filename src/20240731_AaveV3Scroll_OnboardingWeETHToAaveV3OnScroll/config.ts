import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Scroll'],
    title: 'Onboarding weETH to Aave V3 on Scroll',
    shortName: 'OnboardingWeETHToAaveV3OnScroll',
    date: '20240731',
    discussion: 'https://governance.aave.com/t/arfc-onboarding-weeth-to-aave-v3-on-scroll/18301',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x252bafcf8ead0bf1869b7ba9fef430caf3977dfd1e1f84e2e4bc1842e83520b4',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Scroll: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'weETH',
            decimals: 18,
            priceFeed: '0x32f924C0e0F1Abf5D1ff35B05eBc5E844dEdD2A9',
            ltv: '72.5',
            liqThreshold: '75',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '2000',
            borrowCap: '400',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            eModeCategory: 'AaveV3ScrollEModes.ETH_CORRELATED',
            asset: '0x01f0a31698C4d065659b9bdC21B3610292a1c506',
          },
        ],
      },
      cache: {blockNumber: 7952321},
    },
  },
};
