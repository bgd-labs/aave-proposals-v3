import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV4Ethereum', 'AaveV4Avalanche'],
    title: 'Aave V4 Risk Stewards Activation',
    shortName: 'AaveV4RiskStewardsActivation',
    date: '20260807',
    author: 'Aave Labs',
    discussion: 'TODO',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV4Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25701834}},
    AaveV4Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 92229650}},
  },
};
