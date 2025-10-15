import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Adopt The SEAL Safe Harbor Agreement',
    shortName: 'AdoptTheSEALSafeHarborAgreement',
    date: '20251006',
    author: 'BGD Labs (@bgdlabs)',
    discussion: 'https://governance.aave.com/t/arfc-adopt-the-seal-safe-harbor-agreement/23059',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23516158}}},
};
