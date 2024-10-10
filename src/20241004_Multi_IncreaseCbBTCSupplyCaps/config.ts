import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Base'],
    title: 'Increase cbBTC Supply Caps',
    shortName: 'IncreaseCbBTCSupplyCaps',
    date: '20241004',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-increase-cbbtc-supply-caps-on-aave-v3-ethereum-market-and-base/19304',
    snapshot: 'Direct AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {CAPS_UPDATE: [{asset: 'cbBTC', supplyCap: '10000', borrowCap: ''}]},
      cache: {blockNumber: 20934819},
    },
    AaveV3Base: {
      configs: {CAPS_UPDATE: [{asset: 'cbBTC', supplyCap: '5000', borrowCap: ''}]},
      cache: {blockNumber: 20884619},
    },
  },
};
