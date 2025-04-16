import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum'],
    title: 'Remove old VotingPortals from Aave Governance',
    shortName: 'RemoveOldVotingPortalsFromAaveGovernance',
    date: '20250405',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22201396}}},
};
