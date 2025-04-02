import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Base'],
    title: 'sUSDe Base Onboarding',
    shortName: 'SUSDeBaseOnboarding',
    date: '20250226',
    author: 'sreno',
    discussion: 'https://governance.aave.com/t/arfc-add-susde-to-aave-v3-base-instance/20842',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x75caa290c8eefe042d8d3959da08c0f6ebbd6a98e45bbbb9a991531f26bd9899',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 4,
            ltv: '88',
            liqThreshold: '90',
            liqBonus: '4',
            label: 'sUSDE stablecoins emode',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'sUSDe',
            decimals: 18,
            priceFeed: '0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2',
            ltv: '70',
            liqThreshold: '73',
            liqBonus: '8.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '1200000',
            borrowCap: '0',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            asset: '0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 26891059},
    },
  },
};
