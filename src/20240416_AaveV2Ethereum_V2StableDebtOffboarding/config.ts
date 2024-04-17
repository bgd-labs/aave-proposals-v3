import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV2Ethereum'],
    title: 'V2 Stable Debt Offboarding',
    shortName: 'V2StableDebtOffboarding',
    date: '20240416',
    discussion: 'https://governance.aave.com/t/bgd-full-deprecation-of-stable-rate/16473',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xb58ef33b4b7f4c35b7a6834b24f11b282d713b5e9f527f29d782aef04886c189',
  },
  poolOptions: {AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19668247}}},
};
