import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Avalanche'],
    title: 'Update PoR Executor V3 Robot',
    shortName: 'UpdatePoRExecutorV3Robot',
    date: '20240617',
    author: 'BGD Labs (@bgdlabs)',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 46823054}}},
};
