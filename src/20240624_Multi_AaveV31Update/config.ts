import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Metis',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Scroll',
      'AaveV3BNB',
    ],
    title: 'Aave v3.1 update',
    shortName: 'AaveV31Update',
    date: '20240624',
    author: 'BGD labs',
    discussion: 'https://governance.aave.com/t/bgd-aave-v3-1-and-aave-origin/17305',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x905264def5a1736097807e33b43bed5271844c6aed9d4f46e047fe6810e39160',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20160113}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 58540838}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 47114314}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 121808033}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 225151498}},
    AaveV3Metis: {configs: {OTHERS: {}}, cache: {blockNumber: 17443648}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 16212761}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 34624158}},
    AaveV3Scroll: {configs: {OTHERS: {}}, cache: {blockNumber: 6837096}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 39885953}},
  },
};
