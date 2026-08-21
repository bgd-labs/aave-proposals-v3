import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: [
      'AaveV3Ethereum',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Sonic',
      'AaveV3Plasma',
    ],
    title: 'July 2026 Funding Update',
    shortName: 'July2026FundingUpdate',
    date: '20260715',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/direct-to-aip-july-2026-funding-update/25277',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x2f86020fc038694a5c4738e3982e4fa92eb315aaa4d3ce2fa2be2a5808a9280b',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25545450}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 484112325}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 48665378}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 47231570}},
    AaveV3Sonic: {configs: {OTHERS: {}}, cache: {blockNumber: 75979570}},
    AaveV3Plasma: {configs: {OTHERS: {}}, cache: {blockNumber: 27178593}},
  },
};
