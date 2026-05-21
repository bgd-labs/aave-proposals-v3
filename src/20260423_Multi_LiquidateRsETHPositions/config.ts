import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Labs',
    markets: ['AaveV3Ethereum', 'AaveV3Arbitrum'],
    title: 'Liquidate rsETH positions',
    shortName: 'LiquidateRsETHPositions',
    date: '20260423',
    discussion: 'https://governance.aave.com/t/rseth-incident-report-april-20-2026/24580',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24993134}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 457933433}},
  },
};
