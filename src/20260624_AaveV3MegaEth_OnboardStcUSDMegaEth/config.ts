import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3MegaEth'],
    title: 'Onboard stcUSD to Aave V3 MegaEth',
    shortName: 'OnboardStcUSDMegaEth',
    date: '20260624',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-onboard-stcusd-to-aave-v3-megaeth/25018',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0x84ccc14e104b18a74ef47375ccd59f7f7aeeb61716dbb2c362ea7a538da3e08f',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3MegaEth: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'stcUSD',
            decimals: 18,
            priceFeed: '0xBBC579Ee0A3fD6E9240965C5f57b7e5b3e3809A8',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'DISABLED',
            reserveFactor: '',
            supplyCap: '10000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x88887bE419578051FF9F4eb6C858A951921D8888',
            admin: '',
          },
        ],
        EMODES_CREATION: [
          {
            ltv: '88',
            liqThreshold: '90',
            liqBonus: '4',
            label: 'stcUSD__Stablecoins',
            isolated: 'ENABLED',
            collateralAssets: ['stcUSD'],
            borrowableAssets: ['USDT0', 'USDm'],
          },
        ],
      },
      cache: {blockNumber: 19510725},
    },
  },
};
