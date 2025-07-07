import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile:
      'src/20250627_AaveV3Ethereum_OnboardSUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance/config.ts',
    force: true,
    update: true,
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Onboard sUSDe September expiry PT tokens on Aave V3 Core Instance',
    shortName: 'OnboardSUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance',
    date: '20250627',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-susde-september-expiry-pt-tokens-on-aave-v3-core-instance/22313',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 17,
            ltv: '85.7',
            liqThreshold: '87.7',
            liqBonus: '5.6',
            label: 'PT-sUSDe Stablecoins September 2025',
          },
          {
            eModeCategory: 18,
            ltv: '87.1',
            liqThreshold: '89.1',
            liqBonus: '3.7',
            label: 'PT-sUSDe USDe Spetember 2025',
          },
        ],
        EMODES_ASSETS: [
          {asset: 'USDC', eModeCategory: '17', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {asset: 'USDT', eModeCategory: '17', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {asset: 'USDe', eModeCategory: '17', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {asset: 'USDe', eModeCategory: '18', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {asset: 'USDS', eModeCategory: '17', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {
            asset: 'PT_sUSDe_25SEP2025',
            eModeCategory: '17',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'PT_sUSDe_25SEP2025',
            eModeCategory: '18',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'PT_sUSDe_25SEP2025',
            decimals: 18,
            priceFeed: '0x7585693910f39df4959912B27D09EAEef06C1a93',
            ltv: '0.05',
            liqThreshold: '0.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '50000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '6',
              variableRateSlope2: '50',
            },
            asset: '0x9F56094C450763769BA0EA9Fe2876070c0fD5F77',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 22868186},
    },
  },
};
