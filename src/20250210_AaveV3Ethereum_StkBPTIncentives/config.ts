import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'stkBPT Incentives',
    shortName: 'StkBPTIncentives',
    date: '20250210',
    author: '@TokenLogic',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21818007}}},
};
