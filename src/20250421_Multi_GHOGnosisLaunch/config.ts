import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum', 'AaveV3Base', 'AaveV3Gnosis'],
    title: 'Launch GHO on Gnosis',
    shortName: 'GHOGnosisLaunch',
    date: '20250421',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-launch-gho-on-gnosis-chain/21379',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x62996204d8466d603fe8c953176599db02a23f440a682ff15ba2d0ca63dda386',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21722753}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 300142041}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 300142041}},
    AaveV3Gnosis: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'GHO',
            decimals: 18,
            priceFeed: '?',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '0',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '0',
            supplyCap: '2500000',
            borrowCap: '2250000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '9.5',
              variableRateSlope2: '50',
            },
            asset: '?',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 25645172},
    },
  },
};
