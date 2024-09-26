import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3EthereumLido'],
    title: 'Set ACI as Emission Manager for wstETH',
    shortName: 'SetACIAsEmissionManagerForWstETH',
    date: '20240923',
    discussion:
      'https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 20812951}}},
};
