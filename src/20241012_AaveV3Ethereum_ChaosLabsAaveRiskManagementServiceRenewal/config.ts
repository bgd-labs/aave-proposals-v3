import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Chaos Labs <> Aave Risk Management Service Renewal',
    shortName: 'ChaosLabsAaveRiskManagementServiceRenewal',
    date: '20241012',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-aave-risk-management-service-renewal/19306',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20952046}}},
};
