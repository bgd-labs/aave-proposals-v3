import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Onboard eBTC and Add eBTC/WBTC E-Mode',
    shortName: 'OnboardEBTCAndAddEBTCWBTCEMode',
    date: '20250324',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-enable-ebtc-wbtc-liquid-e-mode-on-aave-v3-core-instance/20141',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x564a45f0a2855799d9be329942fa1f5e849058ff4b950f4027ec4666f4b61d9c',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 7, ltv: '83', liqThreshold: '85', liqBonus: '3', label: 'eBTC/WBTC'},
        ],
        EMODES_ASSETS: [
          {
            asset: 'WETH',
            eModeCategory: 'AaveV3EthereumEModes.SUSDE_STABLECOINS',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'WBTC',
            eModeCategory: 'AaveV3EthereumEModes.SUSDE_STABLECOINS',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'eBTC',
            decimals: 8,
            priceFeed: '0x95a85D0d2f3115702d813549a80040387738A430',
            ltv: '67',
            liqThreshold: '72',
            liqBonus: '10',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '50',
            supplyCap: '80',
            borrowCap: '8',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '4',
              variableRateSlope2: '300',
            },
            asset: '0x657e8C867D8B37dCC18fA4Caead9C45EB088C642',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 22116242},
    },
  },
};
