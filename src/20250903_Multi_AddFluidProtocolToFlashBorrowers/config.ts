import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Polygon', 'AaveV3Avalanche'],
    title: 'Add Fluid Protocol to flashBorrowers',
    shortName: 'AddFluidProtocolToFlashBorrowers',
    date: '20250903',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-add-fluid-protocol-to-flashborrowers/23007',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x5e13f3e63fd9a2d4d00ff9f7915644e48d4b8b35fe03b52a599b4bc1c95914d0',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Polygon: {
      configs: {FLASH_BORROWER: {address: '0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7'}},
      cache: {blockNumber: 75989845},
    },
    AaveV3Avalanche: {
      configs: {FLASH_BORROWER: {address: '0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7'}},
      cache: {blockNumber: 68093040},
    },
  },
};
