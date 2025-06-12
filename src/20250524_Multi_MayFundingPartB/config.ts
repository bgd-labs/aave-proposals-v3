import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Base'],
    title: 'May Funding Part B',
    shortName: 'MayFundingPartB',
    date: '20250524',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-may-2025-funding-update/21906',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x4dfc398fabb63305900572dff38b2ff8e104b0710077f6b7e48049de173d186b',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22552293}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 30647717}},
  },
};
