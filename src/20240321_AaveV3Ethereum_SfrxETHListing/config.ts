import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20240321_AaveV3Ethereum_SfrxETHListing/config.ts',
    force: true,
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'sfrxETH Listing',
    shortName: 'SfrxETHListing',
    date: '20240321',
    discussion: 'https://governance.aave.com/t/arfc-onboarding-sfrxeth-to-aave-v3-ethereum/15673',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x7b5eb16470a0246d8515fc551962740735c7db93bf7c39810e7d3126c04e49c3',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'sfrxETH',
            decimals: 18,
            priceFeed: '0x0000000000000000000000000000000000000000',
            ltv: '74.5',
            liqThreshold: '77',
            liqBonus: '5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '55000',
            borrowCap: '5500',
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
            asset: '0xac3E018457B222d93114458476f3E3416Abbe38F',
          },
        ],
      },
      cache: {blockNumber: 19479117},
    },
  },
};
