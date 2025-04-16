import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3EthereumLido'],
    title: 'Renew LlamaRisk as Risk Service Provider - epoch 3',
    shortName: 'RenewLlamaRiskAsRiskServiceProviderEpoch3',
    date: '20250413',
    discussion:
      'https://governance.aave.com/t/arfc-renew-llamarisk-as-risk-service-provider-epoch-3/21666',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x70ce585823c2c1a60cb6bbd64750682a2a9a4b501e3f4342812ebf6bb5d51892',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 22262655}}},
};
