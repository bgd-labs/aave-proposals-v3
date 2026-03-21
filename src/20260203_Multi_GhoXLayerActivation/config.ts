import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Avalanche',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Plasma',
      'AaveV3Mantle',
      'AaveV3InkWhitelabel',
    ],
    title: 'Gho X-Layer Activation',
    shortName: 'GhoXLayerActivation',
    date: '20260203',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-launch-gho-on-x-layer-set-aci-as-emissions-manager-for-rewards/23178',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x251c520f1f1da8287168420fa2d2a73a2eb5342c3c62508553123129dec059b0',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24621035}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 77188767}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 428237798}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 43024117}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 45066125}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 16147000}},
    AaveV3Mantle: {configs: {OTHERS: {}}, cache: {blockNumber: 92474200}},
    AaveV3InkWhitelabel: {configs: {OTHERS: {}}, cache: {blockNumber: 39580201}},
  },
};
