import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'wstETH CAPO Oracle Incident User Reimbursement',
    shortName: 'WstETHCAPOOracleIncidentUserReimbursement',
    date: '20260312',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-wsteth-capo-oracle-incident-user-reimbursement/24275?u=tokenlogic',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24642267}}},
};
