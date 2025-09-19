import {ConfigFile, VOTING_NETWORK} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Avalanche',
      'AaveV3Gnosis',
      'AaveV3InkWhitelabel',
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
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 68979823}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 380827682}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 35752827}},
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23346860}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 42203538}},
    AaveV3InkWhitelabel: {
      configs: {OTHERS: {}},
      cache: {blockNumber: 24796622},
    },
  },
};
