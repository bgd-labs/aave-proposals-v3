import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Increase CCIP Facilitator Capacity',
    shortName: 'IncreaseCCIPFacilitatorCapacity',
    date: '20240707',
    author: '@karpatkey_TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-gho-arb-increase-ccip-facilitator-capacity/18169',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20257789}}},
};
