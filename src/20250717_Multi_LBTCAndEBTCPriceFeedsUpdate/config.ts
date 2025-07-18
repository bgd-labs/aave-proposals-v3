import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum', 'AaveV3Base'],
    title: 'LBTC and eBTC Price Feeds Update',
    shortName: 'LBTCAndEBTCPriceFeedsUpdate',
    date: '20250717',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-lbtc-oracle-and-capo-implementation-update/22614',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        PRICE_FEEDS_UPDATE: [
          {asset: 'LBTC', priceFeed: '0xf8c04B50499872A5B5137219DEc0F791f7f620D0'},
        ],
        OTHERS: {},
      },
      cache: {blockNumber: 22937843},
    },
    AaveV3Base: {
      configs: {
        PRICE_FEEDS_UPDATE: [
          {asset: 'LBTC', priceFeed: '0xA04669FE5cba4Bb21f265B562D23e562E45A1C67'},
        ],
      },
      cache: {blockNumber: 32976516},
    },
  },
};
