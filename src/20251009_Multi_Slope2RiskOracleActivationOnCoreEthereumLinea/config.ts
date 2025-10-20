import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Linea'],
    title: 'Slope2 Risk Oracle Activation On Core Ethereum, Linea',
    shortName: 'Slope2RiskOracleActivationOnCoreEthereumLinea',
    date: '20251009',
    author: 'BGD Labs (@bgdlabs)',
    discussion: 'https://governance.aave.com/t/technical-maintenance-proposals/15274/118',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23540610}},
    AaveV3Linea: {configs: {OTHERS: {}}, cache: {blockNumber: 24333194}},
  },
};
