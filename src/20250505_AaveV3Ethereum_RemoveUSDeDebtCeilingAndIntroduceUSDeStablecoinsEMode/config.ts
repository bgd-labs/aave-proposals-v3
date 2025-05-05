import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile:
      'src/20250505_AaveV3Ethereum_RemoveUSDeDebtCeilingAndIntroduceUSDeStablecoinsEMode/config.ts',
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: ' Remove USDe Debt Ceiling and Introduce USDe Stablecoins E-mode',
    shortName: 'RemoveUSDeDebtCeilingAndIntroduceUSDeStablecoinsEMode',
    date: '20250505',
    discussion:
      'https://governance.aave.com/t/arfc-remove-usde-debt-ceiling-and-introduce-usde-stablecoins-e-mode/21876',
    snapshot: 'Direct-To-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'USDe',
            ltv: '',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '0',
            liqProtocolFee: '',
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 11,
            ltv: '90',
            liqThreshold: '93',
            liqBonus: '2',
            label: 'USDe Stablecoin',
          },
        ],
        EMODES_ASSETS: [
          {asset: 'USDC', eModeCategory: '11', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {asset: 'USDT', eModeCategory: '11', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {asset: 'USDe', eModeCategory: '11', collateral: 'ENABLED', borrowable: 'DISABLED'},
          {asset: 'USDS', eModeCategory: '11', collateral: 'DISABLED', borrowable: 'ENABLED'},
        ],
      },
      cache: {blockNumber: 22416856},
    },
  },
};
