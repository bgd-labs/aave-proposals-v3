import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Base'],
    title: 'Onboard CbBTC on Mainnet and Base',
    shortName: 'OnboardCbBTCOnMainnetAndBase',
    date: '20240917',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-cbbtc-to-aave-v3-on-base-and-mainnet/18988',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x7dd65a983a069e9e4def961e116b78acef6965ecb63aebfb26e34a1dcd97b060',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'cbBTC',
            decimals: 8,
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
            supplyCap: '450',
            borrowCap: '45',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '4',
              variableRateSlope2: '300',
            },
            eModeCategory: 'AaveV3EthereumEModes.NONE',
            asset: '0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf',
          },
        ],
      },
      cache: {blockNumber: 20768463},
    },
    AaveV3Base: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'cbBTC',
            decimals: 8,
            priceFeed: '0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F',
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
            supplyCap: '200',
            borrowCap: '20',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '4',
              variableRateSlope2: '300',
            },
            eModeCategory: 'AaveV3BaseEModes.NONE',
            asset: '0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf',
          },
        ],
      },
      cache: {blockNumber: 19882171},
    },
  },
};
