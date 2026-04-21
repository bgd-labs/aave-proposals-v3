import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Umbrella Pause',
    shortName: 'UmbrellaPause',
    date: '20260420',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-pause-stkwaweth-umbrella-staked-token-on-ethereum-v3/24595',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 24927750}}},
};
