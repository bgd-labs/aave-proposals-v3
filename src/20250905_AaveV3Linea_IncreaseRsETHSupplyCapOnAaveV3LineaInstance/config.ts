import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Linea'],
    title: ' Increase rsETH Supply Cap on Aave V3 Linea Instance',
    shortName: 'IncreaseRsETHSupplyCapOnAaveV3LineaInstance',
    date: '20250905',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-increase-rseth-supply-cap-on-aave-v3-linea-instance/23073',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Linea: {
      configs: {CAPS_UPDATE: [{asset: 'wrsETH', supplyCap: '70000', borrowCap: ''}]},
      cache: {blockNumber: 22963642},
    },
  },
};
