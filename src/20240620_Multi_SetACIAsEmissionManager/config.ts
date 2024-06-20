import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum'],
    title: 'Set ACI as Emission Manager',
    shortName: 'SetACIAsEmissionManager',
    date: '20240620',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898#arfc-set-aci-as-emission-manager-for-liquidity-mining-programs-1',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x364de11d3a298f2c76721a8926cb32823cc29d0a95eadecbc0a98c628a38194b',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20132543}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 223817611}},
  },
};
