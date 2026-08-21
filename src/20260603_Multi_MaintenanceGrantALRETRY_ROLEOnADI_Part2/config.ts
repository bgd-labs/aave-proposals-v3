import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: [
      'AaveV3Linea',
      'AaveV3Celo',
      'AaveV3Sonic',
      'AaveV3Soneium',
      'AaveV3Plasma',
      'AaveV3Mantle',
      'AaveV3MegaEth',
      'AaveV3XLayer',
      'AaveV3InkWhitelabel',
    ],
    title: 'Maintenance: Grant AL RETRY_ROLE on a.DI (Part 2)',
    shortName: 'MaintenanceGrantALRETRY_ROLEOnADI_Part2',
    date: '20260603',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-grant-aave-labs-retry-role-on-a-di/25020',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3Linea: {configs: {OTHERS: {}}, cache: {blockNumber: 31054604}},
    AaveV3Celo: {configs: {OTHERS: {}}, cache: {blockNumber: 69723976}},
    AaveV3Sonic: {configs: {OTHERS: {}}, cache: {blockNumber: 74071830}},
    AaveV3Soneium: {configs: {OTHERS: {}}, cache: {blockNumber: 24244992}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 24684836}},
    AaveV3Mantle: {configs: {OTHERS: {}}, cache: {blockNumber: 96747210}},
    AaveV3MegaEth: {configs: {OTHERS: {}}, cache: {blockNumber: 18827721}},
    AaveV3XLayer: {configs: {OTHERS: {}}, cache: {blockNumber: 62855697}},
    AaveV3InkWhitelabel: {configs: {OTHERS: {}}, cache: {blockNumber: 48128811}},
  },
};
