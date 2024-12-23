import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum', 'AaveV3Base'],
    title: 'GHO Base Launch',
    shortName: 'GHOBaseLaunch',
    date: '20241223',
    author: 'Aave Labs',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21463360}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 287752362}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 24072751}},
  },
};
