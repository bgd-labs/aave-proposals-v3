import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Plasma'],
    title: 'WeETH Plasma e-mode update',
    shortName: 'WeETHPlasmaEModeUpdate',
    date: '20251110',
    author: 'Choas Labs (implemented by ACI)',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-weeth-e-mode-risk-parameter-adjustment-on-aave-v3-plasma-instance/23381',
    snapshot: '',
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
            liqBonus: '',
            label: '',
          },
        ],
      },
      cache: {blockNumber: 5851943},
    },
  },
};
