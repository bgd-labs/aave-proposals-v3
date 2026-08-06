import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Arbitrum',
      'AaveV3Avalanche',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Mantle',
      'AaveV3Plasma',
      'AaveV3XLayer',
      'AaveV3Monad',
      'AaveV3Ink',
    ],
    title: 'Remote GSM Launch: Arbitrum',
    shortName: 'RemoteGSMLaunchArbitrum',
    date: '20260512',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-launch-remotegsm-on-arbitrum/24986',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0xf24321514fb593af9e5082d26a1358819ec0f648db8fdb5c2b083f53ef785793',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {}, cache: {blockNumber: 25424170}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 478622035}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 89068025}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 47979045}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 46947490}},
    AaveV3Mantle: {configs: {OTHERS: {}}, cache: {blockNumber: 97309200}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 25809490}},
    AaveV3XLayer: {configs: {OTHERS: {}}, cache: {blockNumber: 64605984}},
    AaveV3Monad: {configs: {OTHERS: {}}, cache: {blockNumber: 85996454}},
    AaveV3Ink: {configs: {OTHERS: {}}, cache: {blockNumber: 49250266}},
  },
};
