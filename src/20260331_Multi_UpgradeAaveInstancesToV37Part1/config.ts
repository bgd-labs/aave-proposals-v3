import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: [
      'AaveV3Ethereum',
      'AaveV3Optimism',
      'AaveV3Gnosis',
      'AaveV3Scroll',
      'AaveV3Celo',
      'AaveV3Sonic',
      'AaveV3MegaEth',
      'AaveV3XLayer',
    ],
    title: 'Upgrade Aave instances to v3.7 Part 1',
    shortName: 'UpgradeAaveInstancesToV37Part1',
    date: '20260331',
    discussion: 'https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075',
    snapshot:
      'https://snapshot.org/#/aavedao.eth/proposal/0x2cdd27eda22b36ddde2303c3d69859f74b330eb93661e632700d18c6095335a8',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24780007}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 149695257}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 45438729}},
    AaveV3Scroll: {configs: {OTHERS: {}}, cache: {blockNumber: 32874280}},
    AaveV3Celo: {configs: {OTHERS: {}}, cache: {blockNumber: 63088537}},
    AaveV3Sonic: {configs: {OTHERS: {}}, cache: {blockNumber: 66403035}},
    AaveV3MegaEth: {configs: {OTHERS: {}}, cache: {blockNumber: 12192286}},
    AaveV3XLayer: {configs: {OTHERS: {}}, cache: {blockNumber: 56220264}},
  },
};
