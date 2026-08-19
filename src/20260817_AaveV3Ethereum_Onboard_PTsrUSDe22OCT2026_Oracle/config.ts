import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3Ethereum'],
    title: 'Onboard PT-srUSDe-22OCT2026 to the LlamaRisk PT Risk Oracle',
    shortName: 'Onboard_PTsrUSDe22OCT2026_Oracle',
    date: '20260817',
    author: 'LlamaRisk',
    discussion: 'https://gov.discussion.placeholder',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25789439}}},
};
