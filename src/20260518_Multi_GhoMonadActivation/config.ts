import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Avalanche',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Plasma',
      'AaveV3Mantle',
      'AaveV3InkWhitelabel',
      'AaveV3XLayer',
      'AaveV3Monad',
    ],
    title: 'Gho Monad Activation',
    shortName: 'GhoMonadActivation',
    date: '20260518',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25374562}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 88588236}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 476224218}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 47679528}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 46830708}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 25208510}},
    AaveV3Mantle: {configs: {OTHERS: {}}, cache: {blockNumber: 97009046}},
    AaveV3InkWhitelabel: {configs: {OTHERS: {}}, cache: {blockNumber: 48649995}},
    AaveV3XLayer: {configs: {OTHERS: {}}, cache: {blockNumber: 63379370}},
    AaveV3Monad: {configs: {OTHERS: {}}, cache: {blockNumber: 82996426}},
  },
};
