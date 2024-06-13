import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Onboarding ETHx to Aave V3',
    shortName: 'OnboardingETHxToAaveV3',
    date: '20240521',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-onboarding-ethx-to-aave-v3-ethereum/15672',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x9238b091250c739f5b5486ab8dbaa110b0b7ec0582698ea2c2d3721377e4b0bb',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'ETHx',
            decimals: 18,
            priceFeed: '0xD6270dAabFe4862306190298C2B48fed9e15C847',
            ltv: '74.500',
            liqThreshold: '77',
            liqBonus: '7.5',
            debtCeiling: '100',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '3200',
            borrowCap: '320',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
              stableRateSlope1: '0',
              stableRateSlope2: '0',
              baseStableRateOffset: '0',
              stableRateExcessOffset: '0',
              optimalStableToTotalDebtRatio: '0',
            },
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            asset: '0xA35b1B31Ce002FBF2058D22F30f95D405200A15b',
          },
        ],
      },
      cache: {blockNumber: 19937144},
    },
  },
};
