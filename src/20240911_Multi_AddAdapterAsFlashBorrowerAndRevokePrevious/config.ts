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
    ],
    title: 'AddAdapterAsFlashBorrowerAndRevokePrevious',
    shortName: 'AddAdapterAsFlashBorrowerAndRevokePrevious',
    date: '20240911',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {FLASH_BORROWER: {address: '0x0000000000000000000000000000000000000001'}},
      cache: {blockNumber: 20729050},
    },
    AaveV3Polygon: {
      configs: {FLASH_BORROWER: {address: '0x0000000000000000000000000000000000000001'}},
      cache: {blockNumber: 61703461},
    },
    AaveV3Avalanche: {
      configs: {FLASH_BORROWER: {address: '0x0000000000000000000000000000000000000001'}},
      cache: {blockNumber: 50408470},
    },
    AaveV3Optimism: {
      configs: {FLASH_BORROWER: {address: '0x0000000000000000000000000000000000000001'}},
      cache: {blockNumber: 125239619},
    },
    AaveV3Arbitrum: {
      configs: {FLASH_BORROWER: {address: '0x0000000000000000000000000000000000000001'}},
      cache: {blockNumber: 252479788},
    },
    AaveV3Base: {
      configs: {FLASH_BORROWER: {address: '0x0000000000000000000000000000000000000001'}},
      cache: {blockNumber: 19644338},
    },
  },
};
