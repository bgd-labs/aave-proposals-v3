import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum'],
    title: 'GHO CCIP Integration Maintenance (CCIP v1.5 upgrade)',
    shortName: 'GHOCCIPIntegrationMaintenanceCCIPV15Upgrade',
    date: '20241017',
    author: 'Aave Labs',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {}, cache: {blockNumber: 20985823}},
    AaveV3Arbitrum: {configs: {}, cache: {blockNumber: 264780207}},
  },
};
