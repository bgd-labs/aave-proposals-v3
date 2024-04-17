import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Gnosis'],
    title: 'EURe Emissions Manager',
    shortName: 'EUReEmissionsManager',
    date: '20240327',
    discussion:
      'https://governance.aave.com/t/arfc-set-aci-as-emissions-manager-for-eure-on-aave-v3-gnosis-market/17130',
    snapshot: 'TODO',
  },
  poolOptions: {
    AaveV3Gnosis: {
      configs: {
        EMISSION_MANAGER: [{asset: 'EURe', admin: '0xac140648435d03f784879cd789130F22Ef588Fcd'}],
      },
      cache: {blockNumber: 33145615},
    },
  },
};
