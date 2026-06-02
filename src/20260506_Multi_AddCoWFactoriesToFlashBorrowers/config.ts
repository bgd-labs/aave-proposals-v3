import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3BNB',
      'AaveV3Linea',
      'AaveV3Plasma',
    ],
    title: 'Add CoW Swap Adapters to flashBorrowers',
    shortName: 'AddCoWFactoriesToFlashBorrowers',
    date: '20260506',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-whitelist-cow-protocol-adapters-as-flash-borrowers-on-aave-v3/24467',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {FLASH_BORROWER: {address: '0xdeCC46a4b09162F5369c5C80383AAa9159bCf192'}},
      cache: {blockNumber: 25035497},
    },
    AaveV3Polygon: {
      configs: {FLASH_BORROWER: {address: '0xdeCC46a4b09162F5369c5C80383AAa9159bCf192'}},
      cache: {blockNumber: 86472283},
    },
    AaveV3Avalanche: {
      configs: {FLASH_BORROWER: {address: '0xdeCC46a4b09162F5369c5C80383AAa9159bCf192'}},
      cache: {blockNumber: 84734234},
    },
    AaveV3Arbitrum: {
      configs: {FLASH_BORROWER: {address: '0xdeCC46a4b09162F5369c5C80383AAa9159bCf192'}},
      cache: {blockNumber: 459957822},
    },
    AaveV3Base: {
      configs: {FLASH_BORROWER: {address: '0xdeCC46a4b09162F5369c5C80383AAa9159bCf192'}},
      cache: {blockNumber: 45637639},
    },
    AaveV3Gnosis: {
      configs: {FLASH_BORROWER: {address: '0xdeCC46a4b09162F5369c5C80383AAa9159bCf192'}},
      cache: {blockNumber: 45935000},
    },
    AaveV3BNB: {
      configs: {FLASH_BORROWER: {address: '0xdeCC46a4b09162F5369c5C80383AAa9159bCf192'}},
      cache: {blockNumber: 96691532},
    },
    AaveV3Linea: {
      configs: {FLASH_BORROWER: {address: '0xdeCC46a4b09162F5369c5C80383AAa9159bCf192'}},
      cache: {blockNumber: 30528055},
    },
    AaveV3Plasma: {
      configs: {FLASH_BORROWER: {address: '0xdeCC46a4b09162F5369c5C80383AAa9159bCf192'}},
      cache: {blockNumber: 21132780},
    },
  },
};
