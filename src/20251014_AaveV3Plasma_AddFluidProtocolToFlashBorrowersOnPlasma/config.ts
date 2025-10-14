import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Plasma'],
    title: 'Add Fluid Protocol to flashBorrowers on Plasma',
    shortName: 'AddFluidProtocolToFlashBorrowersOnPlasma',
    date: '20251014',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-add-fluid-protocol-to-flashborrowers-on-plasma/23252',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Plasma: {
      configs: {FLASH_BORROWER: {address: '0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7'}},
      cache: {blockNumber: 3526245},
    },
  },
};
