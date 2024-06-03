import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum'],
    title: 'GHO Cross-Chain Launch',
    shortName: 'GHOCrossChainLaunch',
    date: '20240528',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-gho-cross-chain-launch/17616',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x2a6ffbcff41a5ef98b7542f99b207af9c1e79e61f859d0a62f3bf52d3280877a',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {}, cache: {blockNumber: 19967293}},
    AaveV3Arbitrum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'GHO',
            decimals: 6,
            priceFeed: '0x3c786e934F23375Ca345C9b8D5aD54838796E8e7',
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
            borrowCap: '1000000',
            rateStrategyParams: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '4',
              variableRateSlope2: '50',
              stableRateSlope1: '0',
              stableRateSlope2: '0',
              baseStableRateOffset: '0',
              stableRateExcessOffset: '0',
              optimalStableToTotalDebtRatio: '0',
            },
            eModeCategory: 'AaveV3ArbitrumEModes.NONE',
            asset: '0xaf88d065e77c8cC2239327C5EDb3A432268e5831',
          },
        ],
        OTHERS: {},
      },
      cache: {blockNumber: 215853041},
    },
  },
};
