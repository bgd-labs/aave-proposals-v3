import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)',
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3BNB',
      'AaveV3Linea',
      'AaveV3Plasma',
    ],
    title: 'Orderly Transition and Offboarding Plan for Chaos Labs',
    shortName: 'OrderlyTransitionAndOffboardingPlanForChaosLabs',
    date: '20260410',
    discussion:
      'https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24850119}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 85356816}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 82595973}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 150117446}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 451063652}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 44522163}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 45604158}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 91740832}},
    AaveV3Linea: {configs: {OTHERS: {}}, cache: {blockNumber: 30151483}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 18901819}},
  },
};
