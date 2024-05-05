import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum'],
    title: 'aAMPL Second Distribution',
    shortName: 'AAMPLSecondDistribution',
    date: '20240429',
    author: 'BGD Labs (@bgdlabs)',
    discussion: 'https://governance.aave.com/t/arfc-aampl-second-distribution/17464',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x372ea60168390ca30be8890ae18ba3c1bb171428ad613a3c8c1a568721c1d65d',
  },
  poolOptions: {AaveV2Ethereum: {configs: {}, cache: {blockNumber: 19760445}}},
};
