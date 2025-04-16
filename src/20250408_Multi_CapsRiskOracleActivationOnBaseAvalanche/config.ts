import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Avalanche', 'AaveV3Base'],
    title: 'Caps Risk Oracle Activation on Base, Avalanche',
    shortName: 'CapsRiskOracleActivationOnBaseAvalanche',
    date: '20250408',
    author: 'BGD Labs (@bgdlabs)',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 59897799}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 28665693}},
  },
};
