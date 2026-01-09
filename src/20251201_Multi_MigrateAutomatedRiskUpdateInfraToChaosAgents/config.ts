import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3EthereumLido',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3BNB',
      'AaveV3Linea',
      'AaveV3Plasma',
    ],
    title: 'Migrate automated risk update infra to chaos agents',
    shortName: 'MigrateAutomatedRiskUpdateInfraToChaosAgents',
    date: '20251201',
    author: 'BGD Labs (@bgdlabs)',
    discussion: 'https://governance.aave.com/t/technical-maintenance-proposals/15274/122',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0x9795f1b7057d2780b3382b9f67f309fbfead98e7357a88df4c309dbbfefcbeb7',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23919441}},
    AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 23919441}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 79748434}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 72918199}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 144501566}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 406083206}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 38906282}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 43428254}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 70133881}},
    AaveV3Linea: {configs: {OTHERS: {}}, cache: {blockNumber: 26224312}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 7671247}},
  },
};
