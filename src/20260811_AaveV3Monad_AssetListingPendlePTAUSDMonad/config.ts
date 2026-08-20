import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3Monad'],
    title: 'Asset Listing - Pendle PT-AUSD Monad',
    shortName: 'AssetListingPendlePTAUSDMonad',
    date: '20260811',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-pt-ausd-8oct2026-to-aave-v3-monad-instance/25331',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0x1d5029f1b99b62843590e28d027a1a5aa21f4fe19f175284197c58779db14027',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3Monad: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'PT_AUSD_8OCT2026',
            decimals: 6,
            priceFeed: '0x6D8f31268E94Bec0b0E07bc06b561b8B749F3127',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            reserveFactor: '20',
            supplyCap: '20000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x9fc74f8ed616b5baf52a170caa97d6d3898602d1',
            admin: '',
          },
        ],
        EMODES_CREATION: [
          {
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '2.44',
            label: 'PT_Agora__Stablecoins',
            isolated: 'ENABLED',
            collateralAssets: ['PT_AUSD_8OCT2026'],
            borrowableAssets: ['USDT0', 'USDC', 'GHO', 'USDe'],
          },
        ],
      },
      cache: {blockNumber: 97672700},
    },
  },
};
