import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20241120_AaveV3Ethereum_EnableCbBTCWBTCLiquidEModeOnAaveV3Mainnet/config.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Enable cbBTC/WBTC liquid E-Mode on Aave v3 Mainnet',
    shortName: 'EnableCbBTCWBTCLiquidEModeOnAaveV3Mainnet',
    date: '20241120',
    discussion:
      'https://governance.aave.com/t/arfc-enable-cbbtc-wbtc-liquid-e-mode-on-aave-v3-mainnet/19705',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xab0c3b74e77d4fbad43ae701ca2c43674f865ca699562e1afbc3d29a732d0557',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 3, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'cbBTC WBTC'},
        ],
        EMODES_ASSETS: [
          {asset: 'WBTC', eModeCategory: '3', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {asset: 'cbBTC', eModeCategory: '3', collateral: 'ENABLED', borrowable: 'DISABLED'},
        ],
      },
      cache: {blockNumber: 21231401},
    },
  },
};
