import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3MegaEth'],
    title: 'Collateral Parameters Adjustment on MegaETH v3',
    shortName: 'CollateralParametersAdjustmentOnMegaETHV3',
    date: '20260402',
    author: 'Chaos Labs (implemented by Aave Labs)',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-collateral-parameters-adjustment-on-aave-v3-megaeth-instance/24334',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3MegaEth: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'WETH',
            ltv: '78',
            liqThreshold: '81',
            liqBonus: '5.5',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'BTCb',
            ltv: '68',
            liqThreshold: '73',
            liqBonus: '6.5',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'wstETH',
            ltv: '75',
            liqThreshold: '79',
            liqBonus: '6.5',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3MegaEthEModes.wstETH__USDT0_USDm',
            ltv: '78.5',
            liqThreshold: '81',
            liqBonus: '6.5',
            label: '',
          },
        ],
      },
      cache: {blockNumber: 12348425},
    },
  },
};
