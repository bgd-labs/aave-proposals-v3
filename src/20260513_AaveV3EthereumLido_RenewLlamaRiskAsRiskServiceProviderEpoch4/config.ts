import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'LlamaRisk',
    markets: ['AaveV3EthereumLido'],
    title: 'Renew LlamaRisk as Risk Service Provider - Epoch 4',
    shortName: 'RenewLlamaRiskAsRiskServiceProviderEpoch4',
    date: '20260513',
    discussion:
      'https://governance.aave.com/t/arfc-renew-llamarisk-as-risk-service-provider-epoch-4/24446',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x139144f55e87579003f5f9ed53fc4b87bd0c7312fc9c356e5e4e164baa3f8077',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 25088434}}},
};
