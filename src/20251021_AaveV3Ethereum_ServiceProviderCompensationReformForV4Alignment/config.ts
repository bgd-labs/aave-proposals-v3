import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Service Provider Compensation Reform for V4 Alignment',
    shortName: 'ServiceProviderCompensationReformForV4Alignment',
    date: '20251021',
    discussion:
      'https://governance.aave.com/t/arfc-service-provider-compensation-reform-for-v4-alignment/23246',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xdf44cfaac72f0413d639d017c299a6491ba74a55fffcfdf74debfba51932891b',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23627170}}},
};
