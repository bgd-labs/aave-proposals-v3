import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Base'],
    title: 'Add EURC to BASE Aave V3',
    shortName: 'AddEURCToBASEAaveV3',
    date: '20250219',
    discussion: 'https://governance.aave.com/t/arfc-add-eurc-to-base-aave-v3/20680',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0xa2d0c8f06e8fae4ba961407f77732c0b6f870e00a349f826a032d20e291e48f6',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'EURC',
            decimals: 6,
            priceFeed: '0xDAe398520e2B67cd3f27aeF9Cf14D93D927f8250',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '4200000',
            borrowCap: '3800000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '8.5',
              variableRateSlope2: '40',
            },
            asset: '0x60a3e35cc302bfa44cb288bc5a4f316fdb1adb42',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 26567562},
    },
  },
};
