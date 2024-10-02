import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Onboard USDC to Aave V3 Lido Instance',
    shortName: 'OnboardUSDCToAaveV3LidoInstance',
    date: '20241002',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-onboard-usdc-to-aave-v3-lido-instance/19201',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x6146daa40066e4000333f628f94263101ae03731ccd9a64303013a26172c9eef',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'USDC',
            decimals: 6,
            priceFeed: '0x736bF902680e68989886e9807CD7Db4B3E015d3C',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'ENABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '30000000',
            borrowCap: '27600000',
            rateStrategyParams: {
              optimalUtilizationRate: '92',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '5.5',
              variableRateSlope2: '60',
            },
            eModeCategory: 'AaveV3EthereumLidoEModes.NONE',
            asset: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
          },
        ],
      },
      cache: {blockNumber: 20877326},
    },
  },
};
