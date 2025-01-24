import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'tmp.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Onboard LBTC & enable LBTC/WBTC liquid E-Mode on Aave v3 Core Instance',
    shortName: 'EnableLBTCWBTCLiquidEModeOnAavev3CoreInstance',
    date: '20241223',
    discussion:
      'https://governance.aave.com/t/arfc-enable-lbtc-wbtc-liquid-e-mode-on-aave-v3-core-instance/20142',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x61f027ea797763c9e01736693570141a27a0a5d4517a6b63d0fd84474e8be995',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 4, ltv: '84', liqThreshold: '86', liqBonus: '3', label: 'LBTC / WBTC'},
        ],
        EMODES_ASSETS: [
          {asset: 'LBTC', eModeCategory: '4', collateral: 'ENABLED', borrowable: 'DISABLED'},
          {asset: 'WBTC', eModeCategory: '4', collateral: 'DISABLED', borrowable: 'ENABLED'},
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'LBTC',
            decimals: 8,
            priceFeed: '0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c',
            ltv: '70',
            liqThreshold: '75',
            liqBonus: '8.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '50',
            supplyCap: '800',
            borrowCap: '80',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '4',
              variableRateSlope2: '300',
            },
            asset: '0x8236a87084f8B84306f72007F36F2618A5634494',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 21466630},
    },
  },
};
