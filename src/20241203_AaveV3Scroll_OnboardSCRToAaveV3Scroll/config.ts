import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Scroll'],
    title: 'Onboard SCR to Aave V3 Scroll',
    shortName: 'OnboardSCRToAaveV3Scroll',
    date: '20241203',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-onboard-scr-to-aave-v3-scroll-instance/19688',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xef7dfa4e96e5f6a7337648d2dd3882f7b10e969c9564c118a34ce99eccec9383',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Scroll: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'SCR',
            decimals: 18,
            priceFeed: '0x26f6F7C468EE309115d19Aa2055db5A74F8cE7A5',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '0',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '360000',
            borrowCap: '180000',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            asset: '0xd29687c813D741E2F938F4aC377128810E217b1b',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 11609572},
    },
  },
};
