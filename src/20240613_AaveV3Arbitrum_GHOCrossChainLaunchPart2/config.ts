import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum'],
    title: 'GHOCrossChainLaunchPart2',
    shortName: 'GHOCrossChainLaunchPart2',
    date: '20240613',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-gho-cross-chain-launch/17616',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x2a6ffbcff41a5ef98b7542f99b207af9c1e79e61f859d0a62f3bf52d3280877a',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Arbitrum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'GHO',
            decimals: 18,
            priceFeed: '0xB05984aD83C20b3ADE7bf97a9a0Cb539DDE28DBb',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '0',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '1000000',
            borrowCap: '900000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '12',
              variableRateSlope2: '65',
              stableRateSlope1: '0',
              stableRateSlope2: '0',
              baseStableRateOffset: '0',
              stableRateExcessOffset: '0',
              optimalStableToTotalDebtRatio: '0',
            },
            eModeCategory: 'AaveV3ArbitrumEModes.NONE',
            asset: '0x7dfF72693f6A4149b17e7C6314655f6A9F7c8B33',
          },
        ],
      },
      cache: {blockNumber: 221463835},
    },
  },
};
