import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'ChaosLabs (performed by Skyward)',
    pools: ['AaveV3EthereumLido'],
    title: 'Orderly Transition and Offboarding Plan for Chaos Labs part2',
    shortName: 'OrderlyTransitionAndOffboardingPlanForChaosLabsPart2',
    date: '20260507',
    discussion:
      'https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 25041854}}},
};
