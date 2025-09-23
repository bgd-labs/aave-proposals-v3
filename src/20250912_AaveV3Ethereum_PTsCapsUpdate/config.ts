import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'PTs caps update',
    shortName: 'PTsCapsUpdate',
    date: '20250912',
    author: 'ACI',
    discussion: '',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        CAPS_UPDATE: [
          {asset: 'PT_sUSDE_27NOV2025', supplyCap: '2400000000', borrowCap: ''},
          {asset: 'PT_USDe_27NOV2025', supplyCap: '1800000000', borrowCap: ''},
        ],
      },
      cache: {blockNumber: 23348439},
    },
  },
};
