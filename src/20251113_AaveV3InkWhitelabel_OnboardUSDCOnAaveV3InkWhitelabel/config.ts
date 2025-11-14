import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Onboard USDC on AaveV3InkWhitelabel',
    shortName: 'OnboardUSDCOnAaveV3InkWhitelabel',
    date: '20251113',
    author: 'ACI',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'USDC',
            decimals: 6,
            priceFeed: '0xd910061259A256B99654Cff414c3bfD503E7F6ea',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '0',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'ENABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '10000000',
            borrowCap: '9500000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '5.5',
              variableRateSlope2: '40',
            },
            asset: '0x2D270e6886d130D724215A266106e6832161EAEd',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 29561410},
    },
  },
};
