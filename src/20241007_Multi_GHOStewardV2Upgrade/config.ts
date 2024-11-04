import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum'],
    title: 'GHO Steward v2 Upgrade',
    shortName: 'GHOStewardV2Upgrade',
    date: '20241007',
    author: '@karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-gho-steward-v2-upgrade/19116',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xc5e7df1536ef9fc71a7d2e2f6fee6e4e20e37a50b4e0f1646616d066b8697da5',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20914155}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 261341067}},
  },
};
