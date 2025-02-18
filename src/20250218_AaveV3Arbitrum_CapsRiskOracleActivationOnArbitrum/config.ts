import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum'],
    title: 'Caps Risk Oracle Activation on Arbitrum',
    shortName: 'CapsRiskOracleActivationOnArbitrum',
    date: '20250218',
    author: 'BGD Labs (@bgdlabs)',
    discussion:
      'https://governance.aave.com/t/arfc-supply-and-borrow-cap-risk-oracle-activation/20834',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x1d8d0d25f3b705bf207a130308658d15256e2cebc58d123e4ad9e7e3a177ac11',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 307265279}}},
};
