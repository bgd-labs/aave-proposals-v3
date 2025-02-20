import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Optimism'],
    title: 'sUSD Risk Parameter Adjustment',
    shortName: 'SUSDRiskParameterAdjustment',
    date: '20250220',
    discussion: 'https://governance.aave.com/t/arfc-susd-risk-parameter-adjustment/20793',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x5c744451272991c7fdf8b3830fa2a51fc18dd0e417d95d9c16da765b27f602ff',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Optimism: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'sUSD',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3OptimismEModes.STABLECOINS',
            ltv: '0.01',
            liqThreshold: '87',
            liqBonus: '',
            label: '',
          },
        ],
      },
      cache: {blockNumber: 132221425},
    },
  },
};
