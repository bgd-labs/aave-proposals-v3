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
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 67445589}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 370958655}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 34520153}},
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23193620}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 41726320}},
    AaveV3InkWhitelabel: {
      configs: {OTHERS: {}},
      cache: {blockNumber: 22331165},
    },
  },
};
