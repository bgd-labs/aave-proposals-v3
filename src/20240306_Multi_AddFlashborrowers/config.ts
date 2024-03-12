import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum', 'AaveV3Optimism', 'AaveV3Arbitrum'],
    title: 'addFlashborrowers',
    shortName: 'AddFlashborrowers',
    date: '20240306',
    discussion:
      'https://governance.aave.com/t/arfc-add-contango-protocol-cian-protocol-and-index-coop-to-flashborrowers-on-aave-v3/16478',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x09bb9e7cffc974d330d82ce7a0b0502b573d6f3b4f839ea15d6629613901e96d',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {FLASH_BORROWER: {address: '0xab515542d621574f9b5212d50593cD0C07e641bD'}},
      cache: {blockNumber: 19377753},
    },
    AaveV3Optimism: {
      configs: {FLASH_BORROWER: {address: '0xab515542d621574f9b5212d50593cD0C07e641bD'}},
      cache: {blockNumber: 117074480},
    },
    AaveV3Arbitrum: {
      configs: {FLASH_BORROWER: {address: '0xab515542d621574f9b5212d50593cD0C07e641bD'}},
      cache: {blockNumber: 187746332},
    },
  },
};
