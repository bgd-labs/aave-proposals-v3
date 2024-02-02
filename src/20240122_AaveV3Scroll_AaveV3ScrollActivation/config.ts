import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Scroll'],
    title: 'Aave v3 Scroll Activation',
    shortName: 'AaveV3ScrollActivation',
    date: '20240122',
    author: 'BGD Labs (@bgdlabs)',
    discussion: 'https://governance.aave.com/t/arfc-aave-v3-deployment-on-scroll-mainnet/16126/',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x8110de95ff2827946ede0a9b8c5b9c1876605163bb1e7f8c637b6b80848224c8',
  },
  poolOptions: {
    AaveV3Scroll: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 1,
            ltv: '90',
            liqThreshold: '93',
            liqBonus: '1',
            priceSource: '0x0000000000000000000000000000000000000000',
            label: 'ETH correlated',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'WETH',
            decimals: 18,
            priceFeed: '0x6bF14CB0A831078629D993FDeBcB182b21A8774C',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '6',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '240',
            borrowCap: '200',
            rateStrategyParams: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '3.3',
              variableRateSlope2: '8',
              stableRateSlope1: '3.3',
              stableRateSlope2: '8',
              baseStableRateOffset: '2',
              stableRateExcessOffset: '8',
              optimalStableToTotalDebtRatio: '20',
            },
            eModeCategory: '0',
            asset: '0x5300000000000000000000000000000000000004',
          },
          {
            assetSymbol: 'USDC',
            decimals: 6,
            priceFeed: '0x43d12Fb3AfCAd5347fA764EeAB105478337b7200',
            ltv: '77',
            liqThreshold: '80',
            liqBonus: '5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'ENABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '1000000',
            borrowCap: '900000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '6',
              variableRateSlope2: '60',
              stableRateSlope1: '6',
              stableRateSlope2: '60',
              baseStableRateOffset: '1',
              stableRateExcessOffset: '8',
              optimalStableToTotalDebtRatio: '20',
            },
            eModeCategory: '0',
            asset: '0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4',
          },
          {
            assetSymbol: 'wstETH',
            decimals: 18,
            priceFeed: '0xdb93e2712a8b36835078f8d28c70fcc95fd6d37c',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '7',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '130',
            borrowCap: '45',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
              stableRateSlope1: '7',
              stableRateSlope2: '300',
              baseStableRateOffset: '2',
              stableRateExcessOffset: '8',
              optimalStableToTotalDebtRatio: '20',
            },
            eModeCategory: '0',
            asset: '0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32',
          },
        ],
      },
      cache: {blockNumber: 2669127},
    },
  },
};
