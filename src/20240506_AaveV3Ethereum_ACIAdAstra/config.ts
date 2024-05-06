import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'ACI Ad Astra',
    shortName: 'ACIAdAstra',
    date: '20240506',
    author: 'Marc Zeller - Aave Chan Initiative',
    discussion: 'https://governance.aave.com/t/arfc-aci-phase-iii-ad-astra/17515',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x477b3dd277c13cc1b0c1086a04b87d221edd5d09ffd588a246457e6dc3bf2b77',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19810085}}},
};
