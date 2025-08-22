import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Arbitrum'],
    title: 'Onboard tBTC to Aave v3 on Arbitrum',
    shortName: 'OnboardTBTCToAaveV3OnArbitrum',
    date: '20250818',
    discussion: 'https://governance.aave.com/t/arfc-onboard-tbtc-to-aave-v3-on-arbitrum/19756',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xb55325cab6b35918810443de265b8cf2f5908acdde935f3e5b57e6625c4615d5',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Arbitrum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'tBTC',
            decimals: 18,
            priceFeed: '0x6ce185860a4963106506C203335A2910413708e9',
            ltv: '73',
            liqThreshold: '78',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '50',
            borrowCap: '25',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '4',
              variableRateSlope2: '300',
            },
            asset: '0x6c84a8f1c29108f47a79964b5fe888d4f4d0de40',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 369802211},
    },
  },
};
