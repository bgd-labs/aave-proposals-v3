import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV2Ethereum'],
    title: 'Migration of remaining gov v2 permissions',
    shortName: 'MigrationOfRemainingGovV2Permissions',
    date: '20240130',
    discussion: '',
    snapshot: '',
  },
  poolOptions: {AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19119958}}},
};
