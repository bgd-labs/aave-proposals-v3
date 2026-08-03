import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3Ethereum'],
    title: 'Umbrella Parameter Update: Target Liquidity and Emission Optimization',
    shortName: 'UmbrellaParameterUpdateTargetLiquidityAndEmissionOptimization',
    date: '20260701',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-umbrella-parameter-update-target-liquidity-and-emission-optimization/25154',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0x1b262e62f554d2a5a68eb56a267e14ec3aeacad5bd185ef328be8b38aca651ca',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25439286}}},
};
