import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido', 'AaveV3ZkSync'],
    title: 'sUSDe and USDe Price Feed Update',
    shortName: 'SUSDeAndUSDePriceFeedUpdate',
    date: '20250213',
    discussion: 'https://governance.aave.com/t/arfc-susde-and-usde-price-feed-update/20495',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0xd09ac8571db4d8e70b57162d526e2e088295f6372d37eb0f2b68c5dfbf16d316',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        PRICE_FEEDS_UPDATE: [
          {asset: 'USDe', priceFeed: '0xC26D4a1c46d884cfF6dE9800B6aE7A8Cf48B4Ff8'},
          {asset: 'sUSDe', priceFeed: '0x42bc86f2f08419280a99d8fbEa4672e7c30a86ec'},
        ],
      },
      cache: {blockNumber: 21840388},
    },
    AaveV3EthereumLido: {
      configs: {
        PRICE_FEEDS_UPDATE: [
          {asset: 'sUSDe', priceFeed: '0x42bc86f2f08419280a99d8fbEa4672e7c30a86ec'},
        ],
      },
      cache: {blockNumber: 21840443},
    },
    AaveV3ZkSync: {
      configs: {
        PRICE_FEEDS_UPDATE: [
          {asset: 'sUSDe', priceFeed: '0x9172A80ed668D3097D45350ffF71F4421ff572e1'},
        ],
      },
      cache: {blockNumber: 55890667},
    },
  },
};
