import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'ChaosLabs',
    pools: ['AaveV3Ethereum'],
    title: 'weETH Risk Parameter Adjustment',
    shortName: 'WeETHRiskParameterAdjustment',
    date: '20241223',
    discussion: 'https://governance.aave.com/t/arfc-weeth-risk-parameter-adjustment/20167',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'weETH',
            ltv: '77.5',
            liqThreshold: '80',
            liqBonus: '7',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 21465762},
    },
  },
};
