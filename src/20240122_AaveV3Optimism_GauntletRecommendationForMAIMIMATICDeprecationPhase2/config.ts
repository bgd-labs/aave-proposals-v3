import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Optimism'],
    title: 'Gauntlet recommendation for MAI / MIMATIC deprecation phase 2',
    shortName: 'GauntletRecommendationForMAIMIMATICDeprecationPhase2',
    date: '20240122',
    author: 'Gauntlet',
    discussion:
      'https://governance.aave.com/t/arfc-gauntlet-recommendation-for-mai-mimatic-deprecation-phase-2/15957',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x67a6941140c0c0662cfbf99254100f58930afb6763b8040c4bdbd0dfbb2a952b',
  },
  poolOptions: {
    AaveV3Optimism: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'MAI',
            ltv: '',
            liqThreshold: '1',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 115182018},
    },
  },
};
