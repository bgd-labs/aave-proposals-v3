import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Orbit Program Renewal',
    shortName: 'OrbitProgramRenewal',
    date: '20240513',
    discussion: 'https://governance.aave.com/t/arfc-orbit-program-renewal-may-2024/17683',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x4a10e2a8ca95024d7cf0791aa82ed262c816ff0ee78bc2f3ab3487e70d731361',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19862601}}},
};
