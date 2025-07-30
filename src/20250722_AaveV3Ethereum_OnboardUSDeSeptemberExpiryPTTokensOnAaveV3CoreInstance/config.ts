import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'conf.ts',
    force: true,
    update: true,
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Onboard USDe September expiry PT tokens on Aave V3 Core Instance',
    shortName: 'OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance',
    date: '20250722',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-usde-september-expiry-pt-tokens-on-aave-v3-core-instance/22620',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '90.3',
            liqThreshold: '92.3',
            liqBonus: '3.5',
            label: 'PT-USDe Stablecoins September 2025',
            collateralAssets: ['PT_USDe_25SEP2025', 'PT_USDe_31JUL2025', 'PT_eUSDE_14AUG2025'],
            borrowableAssets: ['USDC', 'USDT', 'USDe', 'USDS'],
          },
          {
            ltv: '91.2',
            liqThreshold: '93.2',
            liqBonus: '2.5',
            label: 'PT-USDe USDe September 2025',
            collateralAssets: ['PT_USDe_25SEP2025', 'PT_USDe_31JUL2025', 'PT_eUSDE_14AUG2025'],
            borrowableAssets: ['USDe'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'PT_USDe_25SEP2025',
            decimals: 18,
            priceFeed: '0x8B17C02d22EE7D6B8D6829ceB710A458de41E84a',
            ltv: '0.05',
            liqThreshold: '0.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '25',
            supplyCap: '50000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0xBC6736d346a5eBC0dEbc997397912CD9b8FAe10a',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 22977391},
    },
  },
};
