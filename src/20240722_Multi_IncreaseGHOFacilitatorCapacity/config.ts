import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum'],
    title: 'Increase GHO Facilitator Capacity',
    shortName: 'IncreaseGHOFacilitatorCapacity',
    date: '20240722',
    author: '@karpatkey_TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-gho-arb-increase-ccip-facilitator-capacity/18386',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {}, cache: {blockNumber: 20362522}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 234895360}},
  },
};
