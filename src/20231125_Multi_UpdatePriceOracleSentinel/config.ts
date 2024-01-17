import {ConfigFile} from '../../generator/types';

export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Optimism', 'AaveV3Arbitrum', 'AaveV3Metis', 'AaveV3Base'],
    title: 'Update PriceOracleSentinel',
    shortName: 'UpdatePriceOracleSentinel',
    date: '20231125',
    author: 'BGD Labs (@bgdlabs)',
    discussion: '',
    snapshot: '',
  },
  poolOptions: {
    AaveV3Optimism: {
      configs: {
        OTHERS: {},
      },
      cache: {
        blockNumber: 112657394,
      },
    },
    AaveV3Arbitrum: {
      configs: {
        OTHERS: {},
      },
      cache: {
        blockNumber: 153919280,
      },
    },
    AaveV3Metis: {
      configs: {
        OTHERS: {},
      },
      cache: {
        blockNumber: 9471772,
      },
    },
    AaveV3Base: {
      configs: {
        OTHERS: {},
      },
      cache: {
        blockNumber: 7062146,
      },
    },
  },
};
