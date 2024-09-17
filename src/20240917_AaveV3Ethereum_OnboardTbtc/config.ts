import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Onboard Tbtc',
    shortName: 'OnboardTbtc',
    date: '20240917',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-tbtc-to-aave-v3-on-ethereum-arbitrum-and-optimism/17686',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x9e2e3bd26866212d0cbd8e7cefcfa21eec9522202fd25b02456b8ff59371db08',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'tBTC',
            decimals: 18,
            priceFeed: '0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c',
            ltv: '73',
            liqThreshold: '78',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '550',
            borrowCap: '275',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '4',
              variableRateSlope2: '300',
            },
            eModeCategory: 'AaveV3EthereumEModes.NONE',
            asset: '0x18084fba666a33d37592fa2633fd49a74dd93a88',
          },
        ],
      },
      cache: {blockNumber: 20769515},
    },
  },
};
