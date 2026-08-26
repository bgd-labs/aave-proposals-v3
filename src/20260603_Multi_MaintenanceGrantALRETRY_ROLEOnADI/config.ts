import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Metis',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Scroll',
      'AaveV3BNB',
    ],
    title: 'Maintenance: Grant AL RETRY_ROLE on a.DI (Part 1)',
    shortName: 'MaintenanceGrantALRETRY_ROLEOnADI',
    date: '20260603',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-grant-aave-labs-retry-role-on-a-di/25020',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25331064}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 88613159}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 88166147}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 153012974}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 474138999}},
    AaveV3Metis: {configs: {OTHERS: {}}, cache: {blockNumber: 22769592}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 47417690}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 46728410}},
    AaveV3Scroll: {configs: {OTHERS: {}}, cache: {blockNumber: 34100777}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 104592530}},
  },
};
