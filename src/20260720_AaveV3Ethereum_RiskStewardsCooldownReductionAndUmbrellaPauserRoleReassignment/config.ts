import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3Ethereum'],
    title: 'Risk Stewards Cooldown Reduction & Umbrella Pauser Role Reassignment',
    shortName: 'RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment',
    date: '20260720',
    author: 'Llama Risk (implemented by Aave Labs)',
    discussion:
      'https://governance.aave.com/t/arfc-risk-stewards-cooldown-reduction-umbrella-pauser-role-reassignment/25068',
    snapshot:
      'https://snapshot.org/#/aavedao.eth/proposal/0x7083921f2f549ffa2cdc294c8ff60fdc82af0becbb7b2f20f4f296c34694aaf2',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25572588}}},
};
