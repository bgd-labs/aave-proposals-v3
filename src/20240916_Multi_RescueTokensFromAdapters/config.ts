import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'RescueTokensFromAdapters',
    shortName: 'RescueTokensFromAdapters',
    date: '20240916',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {}, cache: {blockNumber: 20765423}},
  },
};
