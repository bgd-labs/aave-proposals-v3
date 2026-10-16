import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20261013_AaveV3XLayer_AaveV3XLayerUSDeListing/config.ts',
    markets: ['AaveV3XLayer'],
    title: 'Onboard USDe to Aave V3 X Layer',
    shortName: 'AaveV3XLayerUSDeListing',
    date: '20261013',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/direct-to-aip-asset-listing-usde-x-layer/25688',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3XLayer: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'USDe',
            decimals: 18,
            priceFeed: '0x7ec7E5497EAf312FE82F8307D05eb0E5f0f157D3',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            reserveFactor: '25',
            supplyCap: '100000000',
            borrowCap: '20000000',
            rateStrategyParams: {
              optimalUtilizationRate: '85',
              baseVariableBorrowRate: '6.3',
              variableRateSlope1: '0.25',
              variableRateSlope2: '45',
            },
            asset: '0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34',
            admin: '',
          },
        ],
        EMODES_CREATION: [
          {
            ltv: '91',
            liqThreshold: '93',
            liqBonus: '2',
            label: 'USDe__Stablecoins',
            isolated: 'DISABLED',
            collateralAssets: ['USDe'],
            borrowableAssets: ['USDT', 'USDG', 'USDC', 'GHO'],
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'USDe',
            eModeCategory: 'AaveV3XLayerEModes.xBTC__USDT_USDG_GHO_USDC',
            collateral: 'KEEP_CURRENT',
            borrowable: 'ENABLED',
            ltvzero: 'KEEP_CURRENT',
          },
          {
            asset: 'USDe',
            eModeCategory: 'AaveV3XLayerEModes.xETH__USDT_USDG_GHO_USDC',
            collateral: 'KEEP_CURRENT',
            borrowable: 'ENABLED',
            ltvzero: 'KEEP_CURRENT',
          },
          {
            asset: 'USDe',
            eModeCategory: 'AaveV3XLayerEModes.xSOL__USDT_USDG_GHO_USDC',
            collateral: 'KEEP_CURRENT',
            borrowable: 'ENABLED',
            ltvzero: 'KEEP_CURRENT',
          },
          {
            asset: 'USDe',
            eModeCategory: 'AaveV3XLayerEModes.WOKB__USDT_USDG_GHO_USDC',
            collateral: 'KEEP_CURRENT',
            borrowable: 'ENABLED',
            ltvzero: 'KEEP_CURRENT',
          },
        ],
      },
      cache: {blockNumber: 73119417},
    },
  },
};
