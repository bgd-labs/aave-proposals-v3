import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Chaos Labs Engagement Amendment',
    shortName: 'ChaosLabsEngagementAmendment',
    date: '20240415',
    author: 'Chaos Labs',
    discussion: 'https://governance.aave.com/t/arfc-chaos-labs-engagement-amendment/17324',
    snapshot: '',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19660101}}},
};
