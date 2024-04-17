import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20240312_AaveV3Ethereum_MainnetPYUSDEmissionsAdmin/config.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Mainnet PYUSD Emissions Admin',
    shortName: 'MainnetPYUSDEmissionsAdmin',
    date: '20240312',
    discussion:
      'https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-pyusd-on-aave-v3-ethereum-market/16837',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xac80b6d5488c4949e30013d8ed88189ed48b64cb47580bee46921b28e3899bb7',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMISSION_MANAGER: [{asset: 'PYUSD', admin: '0xac140648435d03f784879cd789130F22Ef588Fcd'}],
      },
      cache: {blockNumber: 19421865},
    },
  },
};
