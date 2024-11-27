import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido', 'AaveV3Arbitrum', 'AaveV3Base'],
    title: 'Fluid Alignment',
    shortName: 'FluidAlignment',
    date: '20241127',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-fluid-alignment-with-inst-purchase/19921',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {FLASH_BORROWER: {address: '0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7'}},
      cache: {blockNumber: 21280537},
    },
    AaveV3EthereumLido: {
      configs: {FLASH_BORROWER: {address: '0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7'}},
      cache: {blockNumber: 21280540},
    },
    AaveV3Arbitrum: {
      configs: {FLASH_BORROWER: {address: '0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7'}},
      cache: {blockNumber: 278916313},
    },
    AaveV3Base: {
      configs: {FLASH_BORROWER: {address: '0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7'}},
      cache: {blockNumber: 22969399},
    },
  },
};
