import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3ZkSync', 'AaveV3Celo'],
    title: 'Enable Price Oracle Sentinel on Aave V3 Celo, ZkSync',
    shortName: 'EnablePriceOracleSentinelOnAaveV3CeloZkSync',
    date: '20250930',
    author: 'BGD Labs (@bgdlabs)',
    discussion: '',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3ZkSync: {configs: {OTHERS: {}}, cache: {blockNumber: 64967448}},
    AaveV3Celo: {configs: {OTHERS: {}}, cache: {blockNumber: 47317796}},
  },
};
