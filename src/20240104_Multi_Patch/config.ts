import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20240104_Multi_Patch/config.ts',
    author: 'BGD Labs @bgdlabs',
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Metis',
      'AaveV3Base',
      'AaveV3Gnosis',
    ],
    title: 'Patch',
    shortName: 'Patch',
    date: '20240104',
    discussion:
      'https://governance.aave.com/t/pre-cautionary-measures-on-three-aave-v3-assets/16037',
    snapshot: '',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 18934274}},
    AaveV3Polygon: {
      configs: {
        FREEZE: [
          {asset: 'WMATIC', shouldBeFrozen: false},
          {asset: 'MaticX', shouldBeFrozen: false},
        ],
      },
      cache: {blockNumber: 51930826},
    },
    AaveV3Avalanche: {
      configs: {
        FREEZE: [
          {asset: 'WAVAX', shouldBeFrozen: false},
          {asset: 'sAVAX', shouldBeFrozen: false},
        ],
      },
      cache: {blockNumber: 39925983},
    },
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 114388130}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 167017329}},
    AaveV3Metis: {configs: {OTHERS: {}}, cache: {blockNumber: 10545407}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 8792857}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 31781458}},
  },
};
