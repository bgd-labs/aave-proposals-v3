import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: './gauntletTooling/config.ts',
    title: 'Freeze and set LTV to 0 for DPI, BAL, CRV, and SUSHI on Aave v3 Polygon, 2024.01.19',
    shortName: 'FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119',
    date: '20240130',
    author: 'Gauntlet',
    discussion:
      'https://governance.aave.com/t/arfc-recommendation-to-freeze-and-set-ltv-to-0-on-low-cap-aave-v3-polygon-collateral-assets/16311',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x8a190af80cffafcbca70727c807ef86933b2e08b5212b447eafab976a9612e75',
    pools: ['AaveV3Polygon'],
  },
  poolOptions: {
    AaveV3Polygon: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'BAL',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'CRV',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'DPI',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'SUSHI',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
        FREEZE: [
          {asset: 'BAL', shouldBeFrozen: true},
          {asset: 'CRV', shouldBeFrozen: true},
          {asset: 'DPI', shouldBeFrozen: true},
          {asset: 'SUSHI', shouldBeFrozen: true},
        ],
      },
      cache: {blockNumber: 52940636},
    },
  },
};
