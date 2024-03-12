import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Optimism'],
    title: 'Optimism susd Emission Admin',
    shortName: 'OptimismSusdEmissionAdmin',
    date: '20240312',
    discussion:
      'https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-susd-on-aave-v3-optimism/16867',
    snapshot:
      'https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-susd-on-aave-v3-optimism/16867',
  },
  poolOptions: {
    AaveV3Optimism: {
      configs: {
        EMISSION_MANAGER: [{asset: 'sUSD', admin: '0xac140648435d03f784879cd789130F22Ef588Fcd'}],
      },
      cache: {blockNumber: 117342386},
    },
  },
};
