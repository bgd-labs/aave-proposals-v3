import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Avalanche'],
    title: 'Onboard AUSD',
    shortName: 'OnboardAUSD',
    date: '20241125',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-onboard-ausd-to-aave-v3-on-avalanche/19689',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x021b40c7042ce770c0ce1ee5ff63591c132a9f0f12e3a1cb92fa209299793dec',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Avalanche: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'AUSD',
            decimals: 6,
            priceFeed: '0x83f32c0882B12Ef16214c417efF11FD9e764bf34',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '0',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '19000000',
            borrowCap: '17400000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '5.5',
              variableRateSlope2: '75',
            },
            asset: '0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 53616852},
    },
  },
};
