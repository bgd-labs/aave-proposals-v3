import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aavechan Initiative @aci',
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido'],
    title: 'Re-enable wstETH borrow caps',
    shortName: 'ReEnableWstETHBorrowCaps',
    date: '20260316',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-re-enable-wsteth-borrow-caps-on-ethereum-core-and-prime-post-capo-incident/24295',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {CAPS_UPDATE: [{asset: 'wstETH', supplyCap: '', borrowCap: '180000'}]},
      cache: {blockNumber: 24669521},
    },
    AaveV3EthereumLido: {
      configs: {CAPS_UPDATE: [{asset: 'wstETH', supplyCap: '', borrowCap: '70000'}]},
      cache: {blockNumber: 24669523},
    },
  },
};
