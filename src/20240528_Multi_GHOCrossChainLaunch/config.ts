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
            priceFeed: '0xB3Fe476e89C87aB9B10Eb4d457e86eB780ED7D2D',
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
              variableRateSlope1: '13',
              variableRateSlope2: '65',
              stableRateSlope1: '0',
              stableRateSlope2: '0',
              baseStableRateOffset: '0',
              stableRateExcessOffset: '0',
              optimalStableToTotalDebtRatio: '0',
            },
            eModeCategory: 'AaveV3ArbitrumEModes.NONE',
            asset: '0x9124bc807e1e9c79b3225b25D8B77BacB65FE622',
          },
        ],
        OTHERS: {},
      },
      cache: {blockNumber: 215853041},
    },
  },
};
