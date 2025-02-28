import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Polygon'],
    title: 'Adjust Aave Polygon V3 Risk Parameters',
    shortName: 'AdjustAavePolygonV3RiskParameters',
    date: '20250228',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-adjust-risk-parameters-for-aave-v2-and-v3-on-polygon/20211/60',
    snapshot: 'Direct-To-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Polygon: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'DAI',
            ltv: '1',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDC',
            ltv: '1',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDT',
            ltv: '70',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDCn',
            ltv: '70',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3PolygonEModes.STABLECOINS',
            ltv: '1',
            liqThreshold: '',
            liqBonus: '',
            label: '',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'DAI',
            eModeCategory: 'AaveV3PolygonEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDC',
            eModeCategory: 'AaveV3PolygonEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDT',
            eModeCategory: 'AaveV3PolygonEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'EURS',
            eModeCategory: 'AaveV3PolygonEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'jEUR',
            eModeCategory: 'AaveV3PolygonEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'EURA',
            eModeCategory: 'AaveV3PolygonEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'miMATIC',
            eModeCategory: 'AaveV3PolygonEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDCn',
            eModeCategory: 'AaveV3PolygonEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 68475670},
    },
  },
};
