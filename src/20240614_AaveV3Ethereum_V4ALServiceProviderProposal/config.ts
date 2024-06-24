import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    title: 'V4 AL Service Provider Proposal',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-al-service-provider-proposal/17974',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x70dfd865b78c4c391e2b0729b907d152e6e8a0da683416d617d8f84782036349',
    pools: ['AaveV3Ethereum'],
    shortName: 'V4ALServiceProviderProposal',
    date: '20240614',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 20092863}}},
};
