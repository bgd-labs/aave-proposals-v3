import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3EthereumLido',
      'AaveV3EthereumEtherFi',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
    ],
    title: 'add flash borrowers',
    shortName: 'AddFlashBorrowers',
    date: '20240906',
    author: 'Karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-add-cian-protocol-to-flashborrowers/18731',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {FLASH_BORROWER: {address: '0x49d9409111a6363d82c4371ffa43faea660c917b'}},
      cache: {blockNumber: 20692283},
    },
    AaveV3EthereumLido: {
      configs: {FLASH_BORROWER: {address: '0x49d9409111a6363d82c4371ffa43faea660c917b'}},
      cache: {blockNumber: 20692293},
    },
    AaveV3EthereumEtherFi: {
      configs: {FLASH_BORROWER: {address: '0x49d9409111a6363d82c4371ffa43faea660c917b'}},
      cache: {blockNumber: 20692301},
    },
    AaveV3Optimism: {
      configs: {FLASH_BORROWER: {address: '0x49d9409111a6363d82c4371ffa43faea660c917b'}},
      cache: {blockNumber: 125018001},
    },
    AaveV3Arbitrum: {
      configs: {FLASH_BORROWER: {address: '0x49d9409111a6363d82c4371ffa43faea660c917b'}},
      cache: {blockNumber: 250718774},
    },
  },
};
