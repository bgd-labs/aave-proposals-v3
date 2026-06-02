import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'ChaosLabs (performed by Skyward)',
    pools: ['AaveV3EthereumLido'],
    title: 'Offboarding Plan for Chaos Labs part 3: Cancel stream 100073',
    shortName: 'AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream',
    date: '20260513',
    discussion:
      'https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 25041854}}},
};
