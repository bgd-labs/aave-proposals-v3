import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3XLayer'],
    title: 'Asset Listing - Pendle PT-USDG X Layer',
    shortName: 'AssetListingPendlePTUSDGXLayer',
    date: '20260811',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/direct-to-aip-pt-usdg-x-layer/25464',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3XLayer: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'PT_USDG_29OCT2026',
            decimals: 6,
            priceFeed: '0x6052839E52ab454F164ee5668e5B523cF5A389Fc',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            reserveFactor: '20',
            supplyCap: '35000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x9a09a9e491db3dd8ada5b1b889991ac9ad5fd362',
            admin: '',
          },
        ],
        EMODES_CREATION: [
          {
            ltv: '92.66',
            liqThreshold: '94.66',
            liqBonus: '2.34',
            label: 'PT_USDG__Stablecoins',
            isolated: 'ENABLED',
            collateralAssets: ['PT_USDG_29OCT2026'],
            borrowableAssets: ['USDT', 'USDG', 'GHO'],
          },
          {
            ltv: '93.59',
            liqThreshold: '95.59',
            liqBonus: '1.34',
            label: 'PT_USDG__USDG',
            isolated: 'ENABLED',
            collateralAssets: ['PT_USDG_29OCT2026'],
            borrowableAssets: ['USDG'],
          },
        ],
      },
      cache: {blockNumber: 68513090},
    },
  },
};
