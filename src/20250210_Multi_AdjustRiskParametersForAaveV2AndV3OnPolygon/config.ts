import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250210_Multi_AdjustRiskParametersForAaveV2AndV3OnPolygon/config.ts',
    force: true,
    update: true,
    author: 'Aave-chan Initiative',
    pools: ['AaveV2Polygon', 'AaveV3Polygon'],
    title: 'Adjust Risk Parameters for Aave V2 and V3 on Polygon',
    shortName: 'AdjustRiskParametersForAaveV2AndV3OnPolygon',
    date: '20250210',
    discussion:
      'https://governance.aave.com/t/arfc-adjust-risk-parameters-for-aave-v2-and-v3-on-polygon/20211',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x48cb2ca277c9cfa0855e8561878836eea182e45dea0e140c03786e533519c2dc',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV2Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 68044431}},
    AaveV3Polygon: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'DAI',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDC',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDT',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDCn',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '60',
            asset: 'USDC',
          },
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '25',
            asset: 'USDT',
          },
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '20',
            asset: 'USDCn',
          },
        ],
      },
      cache: {blockNumber: 68044431},
    },
  },
};
