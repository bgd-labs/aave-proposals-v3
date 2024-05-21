import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum', 'AaveV2Polygon', 'AaveV2Avalanche'],
    title: 'LT/LTV Reductions on Aave V2 Stablecoins',
    shortName: 'LTLTVReductionsOnAaveV2Stablecoins',
    date: '20240510',
    author: 'ChaosLabs',
    discussion: 'https://governance.aave.com/t/arfc-lt-ltv-reductions-on-aave-v2-stablecoins/17508',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xe3a29b7d6d936a22ee340811f842a29e4be654e08972f53f43dde7748c722195',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {}, cache: {blockNumber: 19841442}},
    AaveV2Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 56811637}},
    AaveV2Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 45274752}},
  },
};
