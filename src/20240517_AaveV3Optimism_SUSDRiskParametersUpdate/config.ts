import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Optimism'],
    title: 'SUSD risk parameters update',
    shortName: 'SUSDRiskParametersUpdate',
    date: '20240517',
    author: 'Chaos Labs, ACI',
    discussion: 'https://governance.aave.com/t/susd-depeg-update-05-16-2024/17719',
    snapshot: '',
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
      },
      cache: {blockNumber: 120178971},
    },
  },
};
