import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Avalanche', 'AaveV3BNB'],
    title: 'Update a.DI implementation and CCIP adapters',
    shortName: 'UpdateADIImplementationAndCCIPAdapters',
    date: '20240313',
    discussion: '',
    snapshot: '',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19424932}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 54601669}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 42840161}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 36928161}},
  },
};
