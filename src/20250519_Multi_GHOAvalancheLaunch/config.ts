import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum', 'AaveV3Base', 'AaveV3Avalanche'],
    title: 'Launch GHO on Avalanche',
    shortName: 'GHOAvalancheLaunch',
    date: '20250519',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards/19339',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    // below values to match /utils/GHOAvalancheLaunch.sol
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22575695}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 341142215}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 30789286}},
    AaveV3Avalanche: {
      configs: {
        // below values to match /AaveV3Avalanche_GHOAvalancheListing_20250519.sol and /utils/GHOAvalancheLaunch.sol
        ASSET_LISTING: [
          {
            assetSymbol: 'GHO',
            decimals: 18,
            priceFeed: '0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12',
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
            supplyCap: '10000000',
            borrowCap: '9000000', // to match /utils/GHOAvalancheLaunch.sol
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '5.5',
              variableRateSlope2: '50',
            },
            asset: '0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
            eModeCategory: '',
          },
        ],
      },
      cache: {blockNumber: 63569943},
    },
  },
};
