import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'GHO Stewards + Borrow Rate Update',
    shortName: 'GHOStewardsBorrowRateUpdate',
    date: '20240324',
    author: 'karpatkey_TokenLogic ACI ChaosLabs',
    discussion: 'https://governance.aave.com/t/arfc-gho-stewards-borrow-rate-update/16956',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xc26346b891974968c6fa1745b2cfa869d2d0e5875e9fc2bd661167ae19314c6b',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 19508206}}},
};
