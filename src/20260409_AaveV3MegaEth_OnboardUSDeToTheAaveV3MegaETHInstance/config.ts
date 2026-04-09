import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3MegaEth'],
    title: 'Onboard USDe to the Aave V3 MegaETH Instance',
    shortName: 'OnboardUSDeToTheAaveV3MegaETHInstance',
    date: '20260409',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-usde-to-the-aave-v3-megaeth-instance/24389',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3MegaEth: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '90',
            liqThreshold: '93',
            liqBonus: '2',
            label: 'USDe-Stablecoins',
            collateralAssets: ['USDe'],
            borrowableAssets: ['USDT0', 'USDm'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'USDe',
            decimals: 18,
            priceFeed: '0x6B00ffb3852E87c13b7f56660a7dfF64191180B3',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '25',
            supplyCap: '50000000',
            borrowCap: '40000000',
            rateStrategyParams: {
              optimalUtilizationRate: '85',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '4',
              variableRateSlope2: '12',
            },
            asset: '0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 12925205},
    },
  },
};
