import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3Ethereum', 'AaveV3XLayer'],
    title: 'UpdateUSDGPriceFeed',
    shortName: 'UpdateUSDGPriceFeed',
    date: '20260514',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/technical-maintenance-proposals/15274/132',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3Ethereum: {
      configs: {
        PRICE_FEEDS_UPDATE: [
          {asset: 'USDG', priceFeed: '0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4'},
          {asset: 'PT_USDG_28MAY2026', priceFeed: '0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4'},
        ],
      },
      cache: {blockNumber: 25352820},
    },
    AaveV3XLayer: {
      configs: {
        PRICE_FEEDS_UPDATE: [
          {asset: 'USDG', priceFeed: '0xe00B2732396a1f047d4A00e0165025A9cF400245'},
        ],
      },
      cache: {blockNumber: 63357897},
    },
  },
};
