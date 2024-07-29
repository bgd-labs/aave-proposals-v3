import {ConfigFile, VOTING_NETWORK} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'TokenLogic + karpatkey Service Provider - Phase II',
    shortName: 'TokenLogicKarpatkeyServiceProviderPartnershipPhase2',
    date: '20240723',
    author: 'TokenLogic & karpatkey',
    discussion:
      'https://governance.aave.com/t/arfc-tokenlogic-karpatkey-financial-service-providers-phase-ii/18285',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xc44ec840f8f7f6ca3ef2f2a4289882c4cdc1a8b3e6e9ad6b811a640097a8016a',
    votingNetwork: VOTING_NETWORK.POLYGON,
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 20370107}}},
};
