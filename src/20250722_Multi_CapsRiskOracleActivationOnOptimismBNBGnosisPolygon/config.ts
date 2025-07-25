import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Polygon', 'AaveV3Optimism', 'AaveV3Gnosis', 'AaveV3BNB'],
    title: 'Caps Risk Oracle Activation on Optimism, BNB, Gnosis, Polygon',
    shortName: 'CapsRiskOracleActivationOnOptimismBNBGnosisPolygon',
    date: '20250722',
    author: 'BGD Labs (@bgdlabs)',
    discussion: 'https://governance.aave.com/t/technical-maintenance-proposals/15274/98',
    snapshot: 'Direct To AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 74268301}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 138791833}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 41215833}},
    AaveV3BNB: {configs: {OTHERS: {}}, cache: {blockNumber: 54912688}},
  },
};
