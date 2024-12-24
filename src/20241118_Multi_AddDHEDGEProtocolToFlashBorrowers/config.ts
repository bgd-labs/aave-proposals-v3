import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Polygon', 'AaveV3Optimism', 'AaveV3Arbitrum', 'AaveV3Base'],
    title: 'Add dHEDGE Protocol to flashBorrowers',
    shortName: 'AddDHEDGEProtocolToFlashBorrowers',
    date: '20241118',
    discussion: 'https://governance.aave.com/t/arfc-add-dhedge-protocol-to-flashborrowers/19547',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Polygon: {
      configs: {FLASH_BORROWER: {address: '0x83d1fa384ec44c2769a3562ede372484f26e141b'}},
      cache: {blockNumber: 64447789},
    },
    AaveV3Optimism: {
      configs: {FLASH_BORROWER: {address: '0x83d1fa384ec44c2769a3562ede372484f26e141b'}},
      cache: {blockNumber: 128181628},
    },
    AaveV3Arbitrum: {
      configs: {FLASH_BORROWER: {address: '0x27d8fdb0251b48d8edd1ad7bedf553cf99abe7b0'}},
      cache: {blockNumber: 275871816},
    },
    AaveV3Base: {
      configs: {FLASH_BORROWER: {address: '0xa672e882acbb96486393d43e0efdab5ebebddc1d'}},
      cache: {blockNumber: 22586604},
    },
  },
};
