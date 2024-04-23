import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Gnosis'],
    title: 'Risk Parameter Updates GNO on V3 Gnosis',
    shortName: 'RiskParameterUpdatesGNOOnV3Gnosis',
    date: '20240415',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-gno-on-v3-gnosis/17340',
    snapshot: '',
  },
  poolOptions: {
    AaveV3Gnosis: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'GNO',
            ltv: '45',
            liqThreshold: '50',
            liqBonus: '',
            debtCeiling: '2000000',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 33455007},
    },
  },
};
