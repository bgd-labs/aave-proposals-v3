import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250818_AaveV3Base_OnboardTBTCToAaveV3OnBase/config.ts',
    force: true,
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Base'],
    title: 'Onboard tBTC to Aave v3 on Base',
    shortName: 'OnboardTBTCToAaveV3OnBase',
    date: '20250818',
    discussion: 'https://governance.aave.com/t/arfc-onboard-tbtc-to-aave-v3-on-base/22226',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'tBTC',
            decimals: 18,
            priceFeed: '0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F',
            ltv: '73',
            liqThreshold: '78',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '130',
            borrowCap: '13',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '4',
              variableRateSlope2: '60',
            },
            asset: '0x236aa50979D5f3De3Bd1Eeb40E81137F22ab794b',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 34377129},
    },
  },
};
