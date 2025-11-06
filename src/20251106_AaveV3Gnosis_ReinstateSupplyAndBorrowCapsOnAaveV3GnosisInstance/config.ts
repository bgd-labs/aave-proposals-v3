import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Gnosis'],
    title: 'Reinstate Supply and Borrow Caps on Aave V3 Gnosis Instance',
    shortName: 'ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance',
    date: '20251106',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-reinstate-supply-and-borrow-caps-on-aave-v3-gnosis-instance/23373',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Gnosis: {
      configs: {
        CAPS_UPDATE: [
          {asset: 'WETH', supplyCap: '3600', borrowCap: '2400'},
          {asset: 'wstETH', supplyCap: '150000', borrowCap: '150'},
          {asset: 'GNO', supplyCap: '140000', borrowCap: '20000'},
          {asset: 'WXDAI', supplyCap: '4000000', borrowCap: '3700000'},
          {asset: 'EURe', supplyCap: '', borrowCap: '22500000'},
          {asset: 'sDAI', supplyCap: '24000000', borrowCap: '1'},
          {asset: 'USDCe', supplyCap: '12000000', borrowCap: '11000000'},
          {asset: 'GHO', supplyCap: '1500000', borrowCap: '1400000'},
        ],
      },
      cache: {blockNumber: 43004019},
    },
  },
};
