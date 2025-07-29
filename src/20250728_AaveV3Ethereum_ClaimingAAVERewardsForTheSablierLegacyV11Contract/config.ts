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
    snapshot: 'https://snapshot.box/#/s:aavedao.eth/proposal/0xd0d6ae015476ab371ea10e68ce270af05f45ec4ebcb105a8d573f606277956e1',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23018377}}},
};
