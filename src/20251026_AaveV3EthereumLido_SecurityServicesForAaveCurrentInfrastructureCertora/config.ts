import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3EthereumLido'],
    title: 'Security Services for Aave Current Infrastructure <> Certora',
    shortName: 'SecurityServicesForAaveCurrentInfrastructureCertora',
    date: '20251026',
    discussion:
      'https://governance.aave.com/t/arfc-security-services-for-aave-current-infrastructure-certora/23221',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xabaa167899193af7aab389c6412d18802845a88b9bb4061952c82ce78e670f71',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 23663673}}},
};
