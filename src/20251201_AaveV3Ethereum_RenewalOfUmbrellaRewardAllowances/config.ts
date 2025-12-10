import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Renewal of Umbrella Reward Allowances',
    shortName: 'RenewalOfUmbrellaRewardAllowances',
    date: '20251201',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-renewal-of-umbrella-reward-allowances/23474',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23916170}}},
};
