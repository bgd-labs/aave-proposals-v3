import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum', 'AaveV3Base'],
    title: 'Launch GHO on Base',
    shortName: 'GHOBaseLaunch',
    date: '20241223',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/arfc-launch-gho-on-base-set-aci-as-emissions-manager-for-rewards/19338',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x03dc21e0423c60082dc23317af6ebaf997610cbc2cbb0f5a385653bd99a524fe',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21564756}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 292550754}},
    AaveV3Base: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'GHO',
            decimals: 18,
            priceFeed: '0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73',
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
            supplyCap: '2500000',
            borrowCap: '2250000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '12',
              variableRateSlope2: '65',
            },
            asset: '0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 24685477},
    },
  },
};
