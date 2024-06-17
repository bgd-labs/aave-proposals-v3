import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Arbitrum'],
    title: 'Set ACI as Emission Manager for Liquidity Mining Programs',
    shortName: 'SetACIAsEmissionManagerForLiquidityMiningPrograms',
    date: '20240617',
    discussion:
      'https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898#arfc-set-aci-as-emission-manager-for-liquidity-mining-programs-1',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x364de11d3a298f2c76721a8926cb32823cc29d0a95eadecbc0a98c628a38194b',
  },
  poolOptions: {
    AaveV3Arbitrum: {
      configs: {
        EMISSION_MANAGER: [{asset: 'ARB', admin: '0xac140648435d03f784879cd789130F22Ef588Fcd'}],
      },
      cache: {blockNumber: 222894776},
    },
  },
};
