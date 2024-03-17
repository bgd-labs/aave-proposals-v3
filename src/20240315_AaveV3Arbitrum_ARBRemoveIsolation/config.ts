import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum'],
    title: 'Remove ARB from Isolation Mode on Arbitrum',
    shortName: 'ARBRemoveIsolation',
    date: '20240315',
    author: 'karpatkey_TokenLogic_ACI',
    discussion:
      'https://governance.aave.com/t/arfc-remove-arb-from-isolation-mode-on-arbitrum-market/16703',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xbc5471496bbc2beda343625cee22c34fc9672785112cc5d19a25ca87c5b422c3',
  },
  poolOptions: {AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 191404560}}},
};
