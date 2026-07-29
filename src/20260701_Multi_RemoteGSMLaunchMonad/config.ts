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
    title: 'Remote GSM Launch: Monad',
    shortName: 'RemoteGSMLaunchMonad',
    date: '20260701',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-deploy-aave-protocol-v3-7-on-monad/24943',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {}, cache: {blockNumber: 25576000}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 485940600}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 90814900}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 48893400}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 47304500}},
    AaveV3Mantle: {configs: {OTHERS: {}}, cache: {blockNumber: 98222900}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 27635800}},
    AaveV3XLayer: {configs: {OTHERS: {}}, cache: {blockNumber: 65807100}},
    AaveV3Monad: {configs: {OTHERS: {}}, cache: {blockNumber: 89055500}},
    AaveV3Ink: {configs: {OTHERS: {}}, cache: {blockNumber: 51077800}},
  },
};
