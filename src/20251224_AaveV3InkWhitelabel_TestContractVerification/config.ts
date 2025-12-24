import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'TestContractVerification',
    shortName: 'TestContractVerification',
    date: '20251224',
    author: 'ACI',
  },
  poolOptions: {AaveV3InkWhitelabel: {configs: {OTHERS: {}}, cache: {blockNumber: 33107662}}},
};
