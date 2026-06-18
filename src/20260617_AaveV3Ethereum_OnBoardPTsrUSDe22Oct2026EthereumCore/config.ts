import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3Ethereum'],
    title: 'OnBoardPTsrUSDe22Oct2026EthereumCore',
    shortName: 'OnBoardPTsrUSDe22Oct2026EthereumCore',
    date: '20260617',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-strata-srusde-22oct2026-pt-tokens-to-v3-core-instance/25113',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'PT_srUSDe_22OCT2026',
            decimals: 18,
            priceFeed: '0xbd1bc41479d0b58167584980fe57fda913d4fb73',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'DISABLED',
            reserveFactor: '45',
            supplyCap: '25000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x59bC9FaE5D62B19d4f8d07D758047aCb9EE19d34',
            admin: '',
            eModeCategory: '0',
          },
        ],
        EMODES_CREATION: [
          {
            ltv: '88.42',
            liqThreshold: '90.42',
            liqBonus: '5.68',
            label: 'PT-srUSDe Stablecoins',
            isolated: 'ENABLED',
            collateralAssets: ['sUSDe', 'PT_srUSDe_22OCT2026'],
            borrowableAssets: ['USDC', 'USDT', 'USDe'],
          },
          {
            ltv: '91.06',
            liqThreshold: '93.06',
            liqBonus: '2.68',
            label: 'PT-srUSDe USDe',
            isolated: 'ENABLED',
            collateralAssets: ['sUSDe', 'PT_srUSDe_22OCT2026'],
            borrowableAssets: ['USDe'],
          },
        ],
      },
      cache: {blockNumber: 25336783},
    },
  },
};
