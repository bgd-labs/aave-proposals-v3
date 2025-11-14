import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Plasma'],
    title: 'weETH e-mode risk adjustment Plasma',
    shortName: 'WeETHEModeRiskAdjustmentPlasma',
    date: '20251114',
    author: 'Chaos Labs (implemented by ACI via Skyward)',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-weeth-e-mode-risk-parameter-adjustment-on-aave-v3-plasma-instance/23381',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Plasma: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3PlasmaEModes.weETH__USDT0',
            ltv: '77.5',
            liqThreshold: '80',
            liqBonus: '7.5',
            label: '',
          },
        ],
      },
      cache: {blockNumber: 6201584},
    },
  },
};
