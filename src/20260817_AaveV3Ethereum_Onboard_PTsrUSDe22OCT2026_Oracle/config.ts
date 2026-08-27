import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3Ethereum'],
    title: 'Onboard PT-srUSDe-22OCT2026 to the LlamaRisk PT Risk Oracle',
    shortName: 'Onboard_PTsrUSDe22OCT2026_Oracle',
    date: '20260817',
    author: 'LlamaRisk',
    discussion:
      'https://governance.aave.com/t/arfc-upgrade-pt-risk-oracle-to-protocol-owned-infrastructure-on-cre/25119',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25789439}}},
};
