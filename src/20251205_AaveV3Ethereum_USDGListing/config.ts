import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'USDG Listing',
    shortName: 'USDGListing',
    date: '20251205',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-onboard-usdg-to-aave-v3-core-instance/23271',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0x31a6ca3a958d1d9f0d560b90487a72af28780a9b19bc6398444c06ee9d3a96fb',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'USDG',
            decimals: 6,
            priceFeed: '0x8adb5187695F773513dEC4b569d21db0341931dA',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '30000000',
            borrowCap: '25000000',
            rateStrategyParams: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '6',
              variableRateSlope2: '50',
            },
            asset: '0xe343167631d89B6Ffc58B88d6b7fB0228795491D',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 23948851},
    },
  },
};
