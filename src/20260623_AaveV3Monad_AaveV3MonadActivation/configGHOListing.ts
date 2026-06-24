import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3Monad'],
    title: 'Aave V3 Monad GHO Listing',
    shortName: 'AaveV3MonadGHOListing',
    date: '20260623',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3Monad: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'GHO',
            decimals: 18,
            priceFeed: '0x26cBccD96502D2EfDb612737bD6aECe19f65109c',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '7.5',
            liqProtocolFee: '5',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            reserveFactor: '10',
            supplyCap: '20000000',
            borrowCap: '18000000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '4',
              variableRateSlope2: '40',
            },
            asset: '0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73',
            admin: '',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: '0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73',
            eModeCategory: 'Maple_syrupUSDC',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
            ltvzero: 'KEEP_CURRENT',
          },
          {
            asset: '0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73',
            eModeCategory: 'Liquid_Leverage',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
            ltvzero: 'KEEP_CURRENT',
          },
        ],
      },
      cache: {blockNumber: 83370000},
    },
  },
};
