import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum'],
    title: 'Ethereum v2 Reserve Factor Adjustment',
    shortName: 'EthereumV2ReserveFactorAdjustment',
    date: '20240304',
    author: 'Karpatkey, TokenLogic, ChaosLabs',
    discussion: 'https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764',
    snapshot: 'TODO',
  },
  poolOptions: {AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19363829}}},
};
