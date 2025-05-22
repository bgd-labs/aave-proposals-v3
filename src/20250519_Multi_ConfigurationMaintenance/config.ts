import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: [
      'AaveV2Ethereum',
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Scroll',
      'AaveV3ZkSync',
    ],
    title: 'Configuration maintenance',
    shortName: 'ConfigurationMaintenance',
    date: '20250519',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {}, cache: {blockNumber: 22516931}},
    AaveV3Ethereum: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'cbETH',
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'rETH',
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'weETH',
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'osETH',
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'ETHx',
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 22516931},
    },
    AaveV3Polygon: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'stMATIC',
            eModeCategory: 'AaveV3PolygonEModes.MATIC_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'MaticX',
            eModeCategory: 'AaveV3PolygonEModes.MATIC_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3PolygonEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 71707823},
    },
    AaveV3Avalanche: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'DAIe',
            eModeCategory: 'AaveV3AvalancheEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDC',
            eModeCategory: 'AaveV3AvalancheEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDt',
            eModeCategory: 'AaveV3AvalancheEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'sAVAX',
            eModeCategory: 'AaveV3AvalancheEModes.AVAX_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'FRAX',
            eModeCategory: 'AaveV3AvalancheEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'MAI',
            eModeCategory: 'AaveV3AvalancheEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 62326137},
    },
    AaveV3Optimism: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'DAI',
            eModeCategory: 'AaveV3OptimismEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDC',
            eModeCategory: 'AaveV3OptimismEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDT',
            eModeCategory: 'AaveV3OptimismEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'sUSD',
            eModeCategory: 'AaveV3OptimismEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3OptimismEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'rETH',
            eModeCategory: 'AaveV3OptimismEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDCn',
            eModeCategory: 'AaveV3OptimismEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 136029207},
    },
    AaveV3Arbitrum: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'DAI',
            eModeCategory: 'AaveV3ArbitrumEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDC',
            eModeCategory: 'AaveV3ArbitrumEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDT',
            eModeCategory: 'AaveV3ArbitrumEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'EURS',
            eModeCategory: 'AaveV3ArbitrumEModes.STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3ArbitrumEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDCn',
            eModeCategory: 'AaveV3ArbitrumEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'weETH',
            eModeCategory: 'AaveV3ArbitrumEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 338308542},
    },
    AaveV3Base: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'cbETH',
            eModeCategory: 'AaveV3BaseEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3BaseEModes.ETH_CORRELATED',
            collateral: 'DISABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'weETH',
            eModeCategory: 'AaveV3BaseEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 30434021},
    },
    AaveV3Gnosis: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3GnosisEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 40141257},
    },
    AaveV3Scroll: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3ScrollEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
          {
            asset: 'weETH',
            eModeCategory: 'AaveV3ScrollEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 15635366},
    },
    AaveV3ZkSync: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3ZkSyncEModes.ETH_CORRELATED',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 60633796},
    },
  },
};
