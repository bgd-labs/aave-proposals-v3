import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Set ACI as Emission Manager for USDS and aUSDS',
    shortName: 'SetACIAsEmissionManagerForUSDSAndAUSDS',
    date: '20240929',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898/18',
    snapshot: 'Direct-To-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20858722}}},
};
