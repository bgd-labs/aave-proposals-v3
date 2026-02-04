import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aavechan Initiative @aci',
    pools: ['AaveV3Base'],
    title: 'Update syrupUSDC liquidation protocol fee',
    shortName: 'UpdateSyrupUSDCLiquidationProtocolFee',
    date: '20260130',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-update-syrupusdc-liquidation-protocol-fee-on-aave-v3-base-instance/23962',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 41503591}}},
};
