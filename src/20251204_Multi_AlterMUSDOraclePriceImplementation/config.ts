import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20251204_Multi_AlterMUSDOraclePriceImplementation/config.ts',
    force: true,
    pools: ['AaveV3Ethereum', 'AaveV3Linea'],
    title: 'Alter mUSD Oracle Price Implementation',
    shortName: 'AlterMUSDOraclePriceImplementation',
    date: '20251204',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-alter-musd-oracle-price-implementation/23489',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        CAPS_UPDATE: [{asset: 'mUSD', supplyCap: '5000000', borrowCap: '4500000'}],
        PRICE_FEEDS_UPDATE: [
          {asset: 'mUSD', priceFeed: '0x8adb5187695F773513dEC4b569d21db0341931dA'},
        ],
      },
      cache: {blockNumber: 23938706},
    },
    AaveV3Linea: {
      configs: {
        CAPS_UPDATE: [{asset: 'mUSD', supplyCap: '20000000', borrowCap: '18000000'}],
        PRICE_FEEDS_UPDATE: [
          {asset: 'mUSD', priceFeed: '0xA77b1C51a76bbB72D17BF467393a540868103097'},
        ],
      },
      cache: {blockNumber: 26320295},
    },
  },
};
