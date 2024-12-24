import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Aave Liquidity Committee Funding Phase V',
    shortName: 'AaveLiquidityCommitteeFundingPhaseV',
    date: '20241209',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-v/20043',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0xe6740e5aec256ccf1dfbf538591f6b1631927f8d950b17067fe6912b74158332',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {}, cache: {blockNumber: 21365006}}},
};
