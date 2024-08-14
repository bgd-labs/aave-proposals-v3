import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20240716_Multi_ReduceReserveFactorOnWstETH/config.ts',
    author: 'Aave Chan Initiative',
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Scroll',
    ],
    title: 'Reduce Reserve Factor on wstETH',
    shortName: 'ReduceReserveFactorOnWstETH',
    date: '20240716',
    discussion: 'https://governance.aave.com/t/arfc-reduce-reserve-factor-on-wsteth/18044/1',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x7ef3a8d68fa8a1b69d298aceddfafe9d2a24eefb19365d995c839b1cd1b0b97d',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '5',
            asset: 'wstETH',
          },
        ],
      },
      cache: {blockNumber: 20320832},
    },
    AaveV3Polygon: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '5',
            asset: 'wstETH',
          },
        ],
      },
      cache: {blockNumber: 59439039},
    },
    AaveV3Optimism: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '5',
            asset: 'wstETH',
          },
        ],
      },
      cache: {blockNumber: 122777686},
    },
    AaveV3Arbitrum: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '5',
            asset: 'wstETH',
          },
        ],
      },
      cache: {blockNumber: 232890608},
    },
    AaveV3Base: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '5',
            asset: 'wstETH',
          },
        ],
      },
      cache: {blockNumber: 17182417},
    },
    AaveV3Gnosis: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '5',
            asset: 'wstETH',
          },
        ],
      },
      cache: {blockNumber: 34999418},
    },
    AaveV3Scroll: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '5',
            asset: 'wstETH',
          },
        ],
      },
      cache: {blockNumber: 7500893},
    },
  },
};
