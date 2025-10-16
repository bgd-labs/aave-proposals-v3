import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Plasma'],
    title: 'Onboard syrupUSDT to Aave V3 Plasma Instance',
    shortName: 'OnboardSyrupUSDTToAaveV3PlasmaInstance',
    date: '20251016',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-syrupusdt-to-aave-v3-plasma-instance/23204',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Plasma: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '90',
            liqThreshold: '92',
            liqBonus: '4',
            label: 'syrupUSDT/USDT0',
            collateralAssets: ['USDT0'],
            borrowableAssets: ['USDT0'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'syrupUSDT',
            decimals: 6,
            priceFeed: '0x0A3F8218a98337Ef37dCAE4F8a8cfaB0711C64cF',
            ltv: '0.05',
            liqThreshold: '0.1',
            liqBonus: '6',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '45',
            supplyCap: '250000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '00',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0xC4374775489CB9C56003BF2C9b12495fC64F0771',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 3703191},
    },
  },
};
