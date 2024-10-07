import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Aave Liquidity Committee Funding Phase IV',
    shortName: 'AaveLiquidityCommitteeFundingPhaseIV',
    date: '20240930',
    author: '@karpatkey_TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-iv/19188',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20863717}}},
};
