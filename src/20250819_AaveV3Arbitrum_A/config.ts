import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum'],
    title: 'a',
    shortName: 'A',
    date: '20250819',
    author: 'a',
    discussion: 'a',
    snapshot: 'a',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Arbitrum: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3ArbitrumEModes.EZETH_WSTETH',
            ltv: '1',
            liqThreshold: '1',
            liqBonus: '1',
            label: '1',
          },
          {
            eModeCategory: 'AaveV3ArbitrumEModes.RSETH_WSTETH',
            ltv: '1',
            liqThreshold: '1',
            liqBonus: '1',
            label: '1',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'ezETH',
            eModeCategory: 'AaveV3ArbitrumEModes.EZETH_WSTETH',
            collateral: 'KEEP_CURRENT',
            borrowable: 'KEEP_CURRENT',
          },
          {
            asset: 'rsETH',
            eModeCategory: 'AaveV3ArbitrumEModes.RSETH_WSTETH',
            collateral: 'KEEP_CURRENT',
            borrowable: 'KEEP_CURRENT',
          },
        ],
      },
      cache: {blockNumber: 370167450},
    },
  },
};
