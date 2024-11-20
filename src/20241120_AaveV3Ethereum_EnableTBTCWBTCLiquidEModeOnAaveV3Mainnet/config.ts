import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20241120_AaveV3Ethereum_EnableTBTCWBTCLiquidEModeOnAaveV3Mainnet/config.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Enable tBTC/WBTC liquid E-Mode on Aave v3 Mainnet',
    shortName: 'EnableTBTCWBTCLiquidEModeOnAaveV3Mainnet',
    date: '20241120',
    discussion:
      'https://governance.aave.com/t/arfc-enable-tbtc-wbtc-liquid-e-mode-on-aave-v3-mainnet/19704',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x317dc7303f98a6363d7aa4284b75e5779cde127c73e815a941a503619575deb6',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 4, ltv: '93', liqThreshold: '95', liqBonus: '1.5', label: 'tBTC WBTC'},
        ],
        EMODES_ASSETS: [
          {asset: 'WBTC', eModeCategory: '4', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {asset: 'tBTC', eModeCategory: '4', collateral: 'ENABLED', borrowable: 'DISABLED'},
        ],
      },
      cache: {blockNumber: 21231401},
    },
  },
};
