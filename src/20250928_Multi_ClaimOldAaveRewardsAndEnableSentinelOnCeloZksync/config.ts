import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum', 'AaveV3ZkSync', 'AaveV3Celo'],
    title: 'Claim old Aave rewards and enable sentinel on celo, zksync',
    shortName: 'ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync',
    date: '20250928',
    author: 'BGD Labs (@bgdlabs)',
    discussion: '',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23461715}},
    AaveV3ZkSync: {configs: {OTHERS: {}}, cache: {blockNumber: 64934655}},
    AaveV3Celo: {configs: {OTHERS: {}}, cache: {blockNumber: 47164416}},
  },
};
