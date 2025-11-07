import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3EthereumLido'],
    title: 'Security Services for Aave v4 <> Certora',
    shortName: 'SecurityServicesForAaveV4Certora',
    date: '20251026',
    discussion: 'https://governance.aave.com/t/arfc-security-services-for-aave-v4-certora/23222',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xc84ffd9516f6c5248a4c79224baaf0191c8ce240a0e48482ce16594da6d0196d',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 23664458}}},
};
