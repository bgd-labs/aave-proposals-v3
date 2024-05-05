import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Chaos Labs Engagement Amendment',
    shortName: 'ChaosLabsEngagementAmendment',
    date: '20240415',
    author: 'Chaos Labs',
    discussion: 'https://governance.aave.com/t/arfc-chaos-labs-engagement-amendment/17324',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x34b6cf5bc9c8a0525c5b32d4ce2ca2ccfce39d15bd0aba5cab46a4e9e78f3ea8',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19660101}}},
};
