import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum'],
    title: 'V2 Deprecation Plan, 2024.01.02',
    shortName: 'V2DeprecationPlan20240102',
    date: '20240103',
    author: 'Gauntlet, Chaos Labs',
    discussion: 'https://governance.aave.com/t/arfc-v2-ethereum-lt-reductions-01-02-2024/16030',
    snapshot: 'Direct-to-AIP',
  },
  poolOptions: {AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 18929805}}},
};
