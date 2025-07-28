import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Claiming AAVE Rewards for the Sablier Legacy v1.1 Contract',
    shortName: 'ClaimingAAVERewardsForTheSablierLegacyV11Contract',
    date: '20250728',
    discussion:
      'https://governance.aave.com/t/arfc-claiming-aave-rewards-for-the-sablier-legacy-v1-1-contract/21975',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23018377}}},
};
