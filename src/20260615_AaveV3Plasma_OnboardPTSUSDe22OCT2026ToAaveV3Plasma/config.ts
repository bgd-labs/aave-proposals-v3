import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3Plasma'],
    title: 'Onboard PT-sUSDe-22OCT2026 to Aave v3 Plasma',
    shortName: 'OnboardPTSUSDe22OCT2026ToAaveV3Plasma',
    date: '20260615',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-pt-susde-22oct2026-to-aave-v3-plasma/25129',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3Plasma: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'PT-sUSDE-22OCT2026',
            decimals: 18,
            priceFeed: '0x9c823f4e19ef68347810a9c139619273b8282b7e',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'DISABLED',
            reserveFactor: '45',
            supplyCap: '150000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0xf7fb83435f455bd970f2d9f943f4eece1941b3e9',
            admin: '',
          },
        ],
        EMODES_CREATION: [
          {
            ltv: '87.71',
            liqThreshold: '89.71',
            liqBonus: '4.87',
            label: 'sUSDe_PT_sUSDe_22OCT2026__Stablecoins',
            collateralAssets: ['sUSDe', 'PT-sUSDE-22OCT2026'],
            borrowableAssets: ['USDT0', 'USDe', 'GHO'],
          },
          {
            ltv: '90.35',
            liqThreshold: '92.35',
            liqBonus: '1.87',
            label: 'sUSDe_PT_sUSDe_22OCT2026__USDe',
            collateralAssets: ['sUSDe', 'PT-sUSDE-22OCT2026'],
            borrowableAssets: ['USDe'],
          },
        ],
      },
      cache: {blockNumber: 24585111},
    },
  },
};
