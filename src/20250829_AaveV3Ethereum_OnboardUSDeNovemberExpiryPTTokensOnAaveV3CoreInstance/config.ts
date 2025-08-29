import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile:
      'src/20250825_AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance/config.ts',
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Onboard USDe November expiry PT tokens on Aave V3 Core Instance',
    shortName: 'OnboardUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance',
    date: '20250829',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-usde-november-expiry-pt-tokens-on-aave-v3-core-instance/23013',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '87.8',
            liqThreshold: '89.8',
            liqBonus: '4.2',
            label: 'PT-USDe Stablecoins Nov 2025',
            collateralAssets: ['PT_USDE_27NOV2025', 'PT_USDE_25SEP2025'],
            borrowableAssets: ['USDC', 'USDT', 'USDe', 'USDS', 'USDtb'],
          },
          {
            ltv: '88.6',
            liqThreshold: '90.6',
            liqBonus: '3.2',
            label: 'PT-USDe USDe Nov 2025',
            collateralAssets: ['PT_USDE_27NOV2025', 'PT_USDE_25SEP2025'],
            borrowableAssets: ['USDe'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'PT_USDe_27NOV2025',
            decimals: 18,
            priceFeed: '0x0000000000000000000000000000000000000000',
            ltv: '0.05',
            liqThreshold: '0.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '45',
            supplyCap: '50000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x62C6E813b9589C3631Ba0Cdb013acdB8544038B7',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 23245917},
    },
  },
};
