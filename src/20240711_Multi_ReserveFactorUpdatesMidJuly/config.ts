import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV2Ethereum',
      'AaveV2Polygon',
      'AaveV2Avalanche',
      'AaveV3Polygon',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Base',
    ],
    title: 'Reserve Factor Updates Mid July',
    shortName: 'ReserveFactorUpdatesMidJuly',
    date: '20240711',
    author: 'karpatkey_TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-increase-bridged-usdc-reserve-factor-across-all-deployments/17787',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x9cc7906f04f45cebeaa48a05ed281f49da00d89c4dd988a968272fa179f14d06',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20279308}},
    AaveV2Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 59207291}},
    AaveV2Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 47809783}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 59207294}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 122527226}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 230891571}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 16931946}},
  },
};
