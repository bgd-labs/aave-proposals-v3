import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Aave Liquidity Committee Funding Phase VII',
    shortName: 'AaveLiquidityCommitteeFundingPhaseVII',
    date: '20250930',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-vii/23143',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x2d105bc85e7805faa1d43e8a069b5c1ae2ee792d6f80cb62ce0e2aeb5b75d713',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23478059}}},
};
