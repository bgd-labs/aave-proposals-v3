import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3BNB',
    ],
    title: 'AddAdapterAsFlashBorrowerAndRevokePrevious',
    shortName: 'AddAdapterAsFlashBorrowerAndRevokePrevious',
    date: '20240912',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {}, cache: {blockNumber: 20734906}},
    AaveV3Polygon: {configs: {}, cache: {blockNumber: 61736283}},
    AaveV3Avalanche: {configs: {}, cache: {blockNumber: 50442202}},
    AaveV3Optimism: {configs: {}, cache: {blockNumber: 125274934}},
    AaveV3Arbitrum: {configs: {}, cache: {blockNumber: 252760729}},
    AaveV3Base: {configs: {}, cache: {blockNumber: 19679651}},
    AaveV3BNB: {configs: {}, cache: {blockNumber: 42190471}},
  },
};
