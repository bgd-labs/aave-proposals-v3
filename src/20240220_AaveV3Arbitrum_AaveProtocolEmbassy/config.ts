import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum'],
    title: 'Aave Protocol Embassy',
    shortName: 'AaveProtocolEmbassy',
    date: '20240220',
    author: 'karpatkey_TokenLogic_ACI',
    discussion:
      'https://governance.aave.com/t/arfc-establishing-the-aave-protocol-embassy-ape/16445',
    snapshot: 'https://governance.aave.com/t/arfc-establishing-the-aave-protocol-embassy-ape/16445',
  },
  poolOptions: {AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 182860683}}},
};
