import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250617_AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance/config.ts',
    force: true,
    update: true,
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3EthereumLido'],
    title: 'Onboard tETH to Aave v3 Prime Instance',
    shortName: 'OnboardTETHToAaveV3PrimeInstance',
    date: '20250617',
    discussion: 'https://governance.aave.com/t/arfc-onboard-teth-to-aave-v3-prime-instance/21873',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x0cef1b470bf48c23d66386816d6a88d97abefb9364fda4e8e28b6ed2cd169945',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 7, ltv: '92', liqThreshold: '94', liqBonus: '2', label: 'tETH/wstETH'},
        ],
        EMODES_ASSETS: [
          {asset: 'wstETH', eModeCategory: '7', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {asset: 'tETH', eModeCategory: '7', collateral: 'ENABLED', borrowable: 'DISABLED'},
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'tETH',
            decimals: 18,
            priceFeed: '0x85968026294b8f8Fb86d6bF3Cda079f9376aD05A',
            ltv: '0.05',
            liqThreshold: '0.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '50',
            supplyCap: '20000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0xD11c452fc99cF405034ee446803b6F6c1F6d5ED8',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 22726345},
    },
  },
};
