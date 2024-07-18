import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20240714_AaveV3Base_IncreaseWeETHCapsOnBase/config.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Base'],
    title: 'Increase weETH Caps on Base',
    shortName: 'IncreaseWeETHCapsOnBase',
    date: '20240714',
    discussion:
      'https://governance.aave.com/t/arfc-increase-supply-and-borrow-caps-for-weeth-on-base/18248',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {CAPS_UPDATE: [{asset: 'weETH', supplyCap: '20000', borrowCap: '9000'}]},
      cache: {blockNumber: 17096115},
    },
  },
};
