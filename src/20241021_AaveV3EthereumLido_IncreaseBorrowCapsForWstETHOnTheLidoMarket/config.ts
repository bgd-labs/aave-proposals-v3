import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile:
      'src/20241021_AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket/config.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3EthereumLido'],
    title: 'Increase Borrow caps for wstETH on the Lido Market',
    shortName: 'IncreaseBorrowCapsForWstETHOnTheLidoMarket',
    date: '20241021',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-borrow-caps-for-wsteth-on-the-lido-market-10-20-24/19539',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {CAPS_UPDATE: [{asset: 'wstETH', supplyCap: '', borrowCap: '14000'}]},
      cache: {blockNumber: 21016338},
    },
  },
};
