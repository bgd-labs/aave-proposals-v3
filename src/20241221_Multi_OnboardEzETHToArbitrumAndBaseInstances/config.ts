import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20241221_Multi_OnboardEzETHToArbitrumAndBaseInstances/config.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Arbitrum', 'AaveV3Base'],
    title: 'Onboard ezETH to Arbitrum and Base Instances',
    shortName: 'OnboardEzETHToArbitrumAndBaseInstances',
    date: '20241221',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-ezeth-to-arbitrum-and-base-instances/19622',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0xf9fa710414237636cba11187111773fac04f74eb1a562d2b50fca86cb72a778e',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Arbitrum: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 3, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'ezETH / wstETH'},
        ],
        EMODES_ASSETS: [
          {asset: 'ezETH', eModeCategory: '3', collateral: 'ENABLED', borrowable: 'DISABLED'},
          {
            asset: 'ezETH',
            eModeCategory: 'AaveV3ArbitrumEModes.ETH_CORRELATED',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {asset: 'wstETH', eModeCategory: '3', collateral: 'DISABLED', borrowable: 'ENABLED'},
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'ezETH',
            decimals: 18,
            priceFeed: '0x8Ed37B72300683c0482A595bfa80fFb793874b15',
            ltv: '72',
            liqThreshold: '75',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '1750',
            borrowCap: '175',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            asset: '0x2416092f143378750bb29b79eD961ab195CcEea5',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 287111756},
    },
    AaveV3Base: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 2, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'ezETH / wstETH'},
        ],
        EMODES_ASSETS: [
          {asset: 'wstETH', eModeCategory: '2', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {
            asset: 'ezETH',
            eModeCategory: 'AaveV3BaseEModes.ETH_CORRELATED',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {asset: 'ezETH', eModeCategory: '2', collateral: 'ENABLED', borrowable: 'DISABLED'},
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'ezETH',
            decimals: 18,
            priceFeed: '0x438e24f5FCDC1A66ecb25D19B5543e0Cb91A44D4',
            ltv: '72',
            liqThreshold: '75',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '1200',
            borrowCap: '120',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            asset: '0x2416092f143378750bb29b79ed961ab195cceea5',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 24002429},
    },
  },
};
