import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: [
      'AaveV3Ethereum',
      'AaveV3Avalanche',
      'AaveV3Gnosis',
      'AaveV3Mantle',
      'AaveV3EthereumLido',
    ],
    title: 'Aave V3 LTV and E-Mode Update',
    shortName: 'AaveV3LTVAndEModeUpdate',
    date: '20260707',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/direct-to-aip-aave-v3-ltv-and-e-mode-update/25067',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV3Ethereum: {
      configs: {
        COLLATERALS_UPDATE: [
          {asset: 'PYUSD', ltv: '0', liqThreshold: '', liqBonus: '', liqProtocolFee: ''},
        ],
        CAPS_UPDATE: [{asset: 'wstETH', supplyCap: '', borrowCap: '7000'}],
      },
      cache: {blockNumber: 25482749},
    },
    AaveV3Avalanche: {
      configs: {
        COLLATERALS_UPDATE: [
          {asset: 'AUSD', ltv: '0', liqThreshold: '', liqBonus: '', liqProtocolFee: ''},
        ],
      },
      cache: {blockNumber: 89734393},
    },
    AaveV3Gnosis: {
      configs: {
        COLLATERALS_UPDATE: [
          {asset: 'wstETH', ltv: '0', liqThreshold: '', liqBonus: '', liqProtocolFee: ''},
        ],
      },
      cache: {blockNumber: 47085302},
    },
    AaveV3Mantle: {
      configs: {
        COLLATERALS_UPDATE: [
          {asset: 'WETH', ltv: '0', liqThreshold: '', liqBonus: '', liqProtocolFee: ''},
          {asset: 'WMNT', ltv: '0', liqThreshold: '', liqBonus: '', liqProtocolFee: ''},
        ],
        EMODES_CREATION: [
          {
            ltv: '40',
            liqThreshold: '45',
            liqBonus: '10',
            label: 'WMNT__Stablecoins',
            isolated: 'DISABLED',
            collateralAssets: ['WMNT'],
            borrowableAssets: ['USDT0', 'USDC', 'GHO'],
          },
        ],
      },
      cache: {blockNumber: 97660998},
    },
    AaveV3EthereumLido: {
      configs: {CAPS_UPDATE: [{asset: 'wstETH', supplyCap: '', borrowCap: '18000'}]},
      cache: {blockNumber: 25482749},
    },
  },
};
