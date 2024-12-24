import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Onboard rsETH to Lido Instance',
    shortName: 'OnboardRsETHToLidoInstance',
    date: '20241205',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-add-rseth-to-aave-v3-ethereum/17696/18',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 5,
            ltv: '92.5',
            liqThreshold: '94.5',
            liqBonus: '1',
            label: 'rsETH LST main',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'wstETH',
            eModeCategory: 'AaveV3EthereumLidoEModes.ETH_CORRELATED',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'ezETH',
            eModeCategory: 'AaveV3EthereumLidoEModes.ETH_CORRELATED',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'rsETH',
            decimals: 18,
            priceFeed: '0x47F52B2e43D0386cF161e001835b03Ad49889e3b',
            ltv: '0.05',
            liqThreshold: '0.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '10000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '1',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '100',
            },
            asset: '0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 21335607},
    },
  },
};
