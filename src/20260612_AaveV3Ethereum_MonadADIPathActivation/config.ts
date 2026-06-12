import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Monad aDI path activation',
    shortName: 'MonadADIPathActivation',
    date: '20260612',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/technical-maintenance-proposals/15274/130',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25301880}}},
};
