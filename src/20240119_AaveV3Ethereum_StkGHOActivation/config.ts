import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'StkGHO Activation',
    shortName: 'StkGHOActivation',
    date: '20240119',
    author: 'Aave Labs & ACI',
    discussion: 'https://governance.aave.com/t/arfc-upgrade-safety-module-with-stkgho/15635',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x4bc99a842adab6cdd8c7d5c7a787ee4c0056be554fde0d008d53b45b3e795065',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19042382}}},
};
