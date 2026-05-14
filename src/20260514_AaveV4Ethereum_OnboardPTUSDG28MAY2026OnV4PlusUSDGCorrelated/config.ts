import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Labs',
    pools: ['AaveV4Ethereum'],
    title: 'Onboard PT-USDG-28MAY2026 on V4 Plus / USDG Correlated',
    shortName: 'OnboardPTUSDG28MAY2026OnV4PlusUSDGCorrelated',
    date: '20260514',
    discussion: 'todo-forum-post',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV4Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25094500}}},
};
