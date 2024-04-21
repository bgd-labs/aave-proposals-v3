import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV2Ethereum', 'AaveV2EthereumAMM', 'AaveV2Polygon', 'AaveV2Avalanche'],
    title: 'Set Price Cap Adapters for Aave V2',
    shortName: 'SetPriceCapAdaptersForAaveV2',
    date: '20240415',
    discussion: '',
    snapshot: '',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {}, cache: {blockNumber: 19659857}},
    AaveV2EthereumAMM: {configs: {}, cache: {blockNumber: 19659857}},
    AaveV2Polygon: {configs: {}, cache: {blockNumber: 55845356}},
    AaveV2Avalanche: {configs: {}, cache: {blockNumber: 44227427}},
  },
};
