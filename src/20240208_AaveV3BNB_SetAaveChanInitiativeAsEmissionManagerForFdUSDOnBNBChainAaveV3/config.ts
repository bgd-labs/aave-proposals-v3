import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3BNB'],
    title: 'Set Aave Chan Initiative as Emission Manager for fdUSD on BNB Chain Aave V3',
    shortName: 'SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3',
    date: '20240208',
    author: ' Aave Chan Initiative (ACI)',
    discussion:
      'https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-fdusd-on-bnb-chain-aave-v3/16558',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x4db0fe8cb6c21abd34e4d38836db72ed7f1b06c91386ec9e637df8786a289d0d',
  },
  poolOptions: {AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 35967871}}},
};
