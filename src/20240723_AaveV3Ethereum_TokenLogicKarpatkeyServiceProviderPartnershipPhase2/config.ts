import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'TokenLogic & karpatkey Service Provider Partnership-phase 2',
    shortName: 'TokenLogicKarpatkeyServiceProviderPartnershipPhase2',
    date: '20240723',
    author: 'TokenLogic & karpatkey',
    discussion:
      'https://governance.aave.com/t/arfc-tokenlogic-karpatkey-financial-service-providers-phase-ii/18285',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 20370107}}},
};
