import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    title: 'AL Service Provider Proposal',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/temp-check-service-provider-proposal/17866',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xbf901f4be94a4661dce8217b3b037a8607ea8953cbe32e7dbde6a882819d64b3',
    pools: ['AaveV3Ethereum'],
    shortName: 'ALServiceProviderProposal',
    date: '20240614',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 20092863}}},
};
