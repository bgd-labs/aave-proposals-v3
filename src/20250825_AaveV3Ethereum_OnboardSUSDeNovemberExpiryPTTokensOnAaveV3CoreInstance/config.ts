import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile:
      'src/20250825_AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance/config.ts',
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Onboard sUSDe November expiry PT tokens on Aave V3 Core Instance',
    shortName: 'OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance',
    date: '20250825',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-susde-november-expiry-pt-tokens-on-aave-v3-core-instance/22894',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '86.1',
            liqThreshold: '88.1',
            liqBonus: '5.4',
            label: 'PT-sUSDe Stablecoins Nov 2025',
            collateralAssets: ['PT_sUSDE_27NOV2025', 'sUSDe', 'PT_sUSDE_25SEP2025'],
            borrowableAssets: ['USDC', 'USDT', 'USDe', 'USDS', 'USDtb'],
          },
          {
            ltv: '87.8',
            liqThreshold: '89.8',
            liqBonus: '3.4',
            label: 'PT-sUSDe USDe Nov 2025',
            collateralAssets: ['PT_sUSDE_27NOV2025', 'PT_sUSDE_25SEP2025'],
            borrowableAssets: ['USDe'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'PT_sUSDe_27NOV2025',
            decimals: 18,
            priceFeed: '0x8B8B73598a2c4b1de6d3b075618434CfC4826632',
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
            supplyCap: '75000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0xe6A934089BBEe34F832060CE98848359883749B3',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 23217884},
    },
  },
};
