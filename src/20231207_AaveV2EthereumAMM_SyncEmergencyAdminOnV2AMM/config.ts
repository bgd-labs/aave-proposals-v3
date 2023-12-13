import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2EthereumAMM'],
    title: 'Sync emergency admin on v2 AMM',
    shortName: 'SyncEmergencyAdminOnV2AMM',
    date: '20231207',
    author: 'BGD Labs (@bgdlabs)',
    discussion: 'https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/10',
    snapshot: '',
  },
  poolOptions: {AaveV2EthereumAMM: {configs: {OTHERS: {}}, cache: {blockNumber: 18735013}}},
};
