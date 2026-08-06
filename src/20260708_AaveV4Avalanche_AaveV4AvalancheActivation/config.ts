import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV4Avalanche'],
    title: 'Aave V4 Avalanche Activation',
    shortName: 'AaveV4AvalancheActivation',
    date: '20260708',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-deploy-aave-v4-on-avalanche/25165',
    snapshot:
      'https://snapshot.org/#/aavedao.eth/proposal/0xe5c4a9387ce1096075f2ad5c3840a915ef730a1ad9180118be8bd4b6f10dacfe',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {AaveV4Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 89744425}}},
};
