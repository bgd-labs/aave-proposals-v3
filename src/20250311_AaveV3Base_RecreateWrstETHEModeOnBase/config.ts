import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Base'],
    title: 'Recreate wrstETH eMode on Base',
    shortName: 'RecreateWrstETHEModeOnBase',
    date: '20250311',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 5,
            ltv: '92.5',
            liqThreshold: '94.5',
            liqBonus: '1',
            label: 'rsETH/wstETH emode',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3BaseEModes.LBTC_CBBTC',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'wrsETH',
            eModeCategory: 'AaveV3BaseEModes.LBTC_CBBTC',
            collateral: 'DISABLED',
            borrowable: 'KEEP_CURRENT',
          },
        ],
        FREEZE: [
          {asset: 'wrsETH', shouldBeFrozen: false},
          {asset: 'LBTC', shouldBeFrozen: false},
        ],
      },
      cache: {blockNumber: 27458351},
    },
  },
};
