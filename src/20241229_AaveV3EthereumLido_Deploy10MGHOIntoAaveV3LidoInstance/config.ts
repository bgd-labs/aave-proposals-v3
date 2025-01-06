import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Deploy 10M GHO into Aave v3 Lido Instance',
    shortName: 'Deploy10MGHOIntoAaveV3LidoInstance',
    date: '20241229',
    author: 'karpatkey_TokenLogic & BGD Labs',
    discussion:
      'https://governance.aave.com/t/arfc-mint-deploy-10m-gho-into-aave-v3-lido-instance/19700',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x4af37d6b4a1c9029c7693c4bdfb646931a9815c4a56d9066ac1fbdbef7cd15e5',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 21510730}}},
};
