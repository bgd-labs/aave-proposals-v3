import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'config.ts',
    force: true,
    author: 'Aave Chan Initiative',
    pools: [
      'AaveV3Base',
      'AaveV3Avalanche',
      'AaveV3Polygon',
      'AaveV3Gnosis',
      'AaveV3BNB',
      'AaveV3Scroll',
    ],
    title: 'Contango FlashBorrower',
    shortName: 'ContangoFlashborrower',
    date: '20240319',
    discussion:
      'https://governance.aave.com/t/arfc-add-contango-protocol-cian-protocol-and-index-coop-to-flashborrowers-on-aave-v3/16478',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x09bb9e7cffc974d330d82ce7a0b0502b573d6f3b4f839ea15d6629613901e96d',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {FLASH_BORROWER: {address: '0xab515542d621574f9b5212d50593cD0C07e641bD'}},
      cache: {blockNumber: 12007301},
    },
    AaveV3Avalanche: {
      configs: {FLASH_BORROWER: {address: '0xab515542d621574f9b5212d50593cD0C07e641bD'}},
      cache: {blockNumber: 43078653},
    },
    AaveV3Polygon: {
      configs: {FLASH_BORROWER: {address: '0xab515542d621574f9b5212d50593cD0C07e641bD'}},
      cache: {blockNumber: 54819969},
    },
    AaveV3Gnosis: {
      configs: {FLASH_BORROWER: {address: '0xab515542d621574f9b5212d50593cD0C07e641bD'}},
      cache: {blockNumber: 32999851},
    },
    AaveV3BNB: {
      configs: {FLASH_BORROWER: {address: '0xab515542d621574f9b5212d50593cD0C07e641bD'}},
      cache: {blockNumber: 37089606},
    },
    AaveV3Scroll: {
      configs: {FLASH_BORROWER: {address: '0xab515542d621574f9b5212d50593cD0C07e641bD'}},
      cache: {blockNumber: 4244173},
    },
  },
};
