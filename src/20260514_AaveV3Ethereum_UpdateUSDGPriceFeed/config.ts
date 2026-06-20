import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Labs',
    pools: ['AaveV3Ethereum'],
    title: 'Update USDG price feed on Aave V3 Ethereum',
    shortName: 'UpdateUSDGPriceFeed',
    date: '20260514',
    discussion: 'TODO',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25352820}}},
};
