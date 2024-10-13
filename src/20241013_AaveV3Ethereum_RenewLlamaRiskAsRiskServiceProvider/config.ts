import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Renew LlamaRisk as Risk Service Provider',
    shortName: 'RenewLlamaRiskAsRiskServiceProvider',
    date: '20241013',
    discussion: 'https://governance.aave.com/t/arfc-renew-llamarisk-as-risk-service-provider/19277',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x3c8116f97f990bf61fe63c636c1ae85630ad355e26881285aa4fefaebd8c9c0d',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20958953}}},
};
