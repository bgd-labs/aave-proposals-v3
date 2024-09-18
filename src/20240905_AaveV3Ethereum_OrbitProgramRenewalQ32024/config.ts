import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Orbit Program Renewal - Q3 2024',
    shortName: 'OrbitProgramRenewalQ32024',
    date: '20240905',
    discussion: 'https://governance.aave.com/t/arfc-orbit-program-renewal-q3-2024/18834',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xea325542397fce607755f6c14be407f60a71a81f3a23c6b3a67e298b9dd8c091',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20685166}}},
};
