import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Aave Liquidity Committee Funding Phase VI',
    shortName: 'AaveLiquidityCommitteeFundingPhaseVI',
    date: '20250410',
    author: 'TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-vi/21682',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x2af009587f8c624f798ec36e20572a69be7fc6321882b1ba19143da29d45f1ac',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {}, cache: {blockNumber: 22242008}}},
};
