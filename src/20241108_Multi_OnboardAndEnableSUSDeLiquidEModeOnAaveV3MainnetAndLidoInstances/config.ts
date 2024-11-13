import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido'],
    title: 'Onboard and Enable sUSDe liquid E-Mode on Aave v3 Mainnet and Lido Instances',
    shortName: 'OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances',
    date: '20241108',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-enable-susde-liquid-e-mode-on-aave-v3-mainnet-and-lido-instance/1970',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 2, ltv: '90', liqThreshold: '92', liqBonus: '3', label: 'sUSDe'},
        ],
        EMODES_ASSETS: [
          {
            asset: 'USDC',
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'sUSDe',
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDS',
            eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: 'KEEP_CURRENT',
            asset: 'sUSDe',
          },
        ],
      },
      cache: {blockNumber: 21142896},
    },
    AaveV3EthereumLido: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 2, ltv: '90', liqThreshold: '92', liqBonus: '3', label: 'sUSDe'},
        ],
        EMODES_ASSETS: [
          {
            asset: 'WETH',
            eModeCategory: 'AaveV3EthereumLidoEModes.ETH_CORRELATED',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'USDS',
            eModeCategory: 'AaveV3EthereumLidoEModes.ETH_CORRELATED',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'USDC',
            eModeCategory: 'AaveV3EthereumLidoEModes.ETH_CORRELATED',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'sUSDe',
            decimals: 18,
            priceFeed: '0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A',
            ltv: '0.05',
            liqThreshold: '0.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '20000000',
            borrowCap: '0',
            rateStrategyParams: {
              optimalUtilizationRate: '1',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
            },
            asset: '0x9D39A5DE30e57443BfF2A8307A4256c8797A3497',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 21142900},
    },
  },
};
