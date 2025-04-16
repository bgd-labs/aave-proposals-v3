import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'AAVE Buybacks allocation',
    shortName: 'AAVEBuybacksAllocation',
    date: '20250403',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-aavenomics-implementation-part-one/21248',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0xf0591fe8e54900da9929fe25c466c2b4a0fac6e8f7a3a000087797363847fb65',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22189779}}},
};
