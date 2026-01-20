import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Cap Update  Jan 8th',
    shortName: 'CapUpdateJan8th',
    date: '20260109',
    author: 'Chaos Labs (implemented by ACI via Skyward)',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {CAPS_UPDATE: [{asset: 'USDC', supplyCap: '80000000', borrowCap: '76000000'}]},
      cache: {blockNumber: 34477835},
    },
  },
};
