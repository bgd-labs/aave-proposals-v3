import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Avalanche'],
    title: 'Set ACI as Emission Manager for wAVAX on the Avalanche network',
    shortName: 'SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork',
    date: '20240620',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898/4',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 46972185}}},
};
