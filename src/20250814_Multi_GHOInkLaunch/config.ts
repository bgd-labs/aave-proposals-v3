import {ConfigFile, VOTING_NETWORK} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Avalanche',
      'AaveV3Gnosis',
      //   'AaveV3Ink', // TODO: AaveV3Ink type needed
    ],
    title: 'Launch GHO on Ink',
    shortName: 'GHOInkLaunch',
    date: '20250814',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/arfc-launch-gho-on-ink-set-aci-as-emissions-manager-for-rewards/22664',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xf066b8a7b1c0f3d4edff72a047809e3e1f57578d2335fd769e23561a25efb795',
    votingNetwork: VOTING_NETWORK.POLYGON,
  },
  poolOptions: {
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 67445589}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 370958655}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 34520153}},
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23193620}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 41726320}},
    // AaveV3Ink: { // TODO: AaveV3Ink type needed
    //   configs: {
    //     ASSET_LISTING: [
    //       {
    //         assetSymbol: 'GHO',
    //         decimals: 18,
    //         priceFeed: '0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6',
    //         ltv: '0',
    //         liqThreshold: '0',
    //         liqBonus: '0',
    //         debtCeiling: '0',
    //         liqProtocolFee: '0',
    //         enabledToBorrow: 'ENABLED',
    //         flashloanable: 'ENABLED',
    //         borrowableInIsolation: 'DISABLED',
    //         withSiloedBorrowing: 'DISABLED',
    //         reserveFactor: '10',
    //         supplyCap: '5000000',
    //         borrowCap: '4500000',
    //         rateStrategyParams: {
    //           optimalUtilizationRate: '90',
    //           baseVariableBorrowRate: '0',
    //           variableRateSlope1: '5.5',
    //           variableRateSlope2: '50',
    //         },
    //         asset: '0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73',
    //         admin: '0xac140648435d03f784879cd789130F22Ef588Fcd', // Emission Admin - ACI multisig address
    //         eModeCategory: '',
    //       },
    //     ],
    //   },
    //   cache: {blockNumber: 22331165},
    // },
  },
};
