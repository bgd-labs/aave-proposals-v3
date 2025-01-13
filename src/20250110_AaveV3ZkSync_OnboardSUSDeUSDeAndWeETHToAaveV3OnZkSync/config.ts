import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250110_AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync/config.ts',
    author: 'Aave-chan Initiative',
    pools: ['AaveV3ZkSync'],
    title: 'Onboard sUSDe, USDe and weETH to Aave v3 on zkSync',
    shortName: 'OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync',
    date: '20250110',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-susde-usde-and-weeth-to-aave-v3-on-zksync/19204',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x6709151a1efa71370a6a0f9a7592d983ed401ac0311cce861fba347081384520',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3ZkSync: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 2,
            ltv: '90',
            liqThreshold: '93',
            liqBonus: '1',
            label: 'weETH correlated',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'weETH',
            decimals: 18,
            priceFeed: '0x32aF9A0a47B332761c8C90E9eC9f53e46e852b2B',
            ltv: '72.5',
            liqThreshold: '75',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '45',
            supplyCap: '300',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '30',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            asset: '0xc1Fa6E2E8667d9bE0Ca938a54c7E0285E9Df924a',
            admin: '0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc',
          },
          {
            assetSymbol: 'sUSDe',
            decimals: 18,
            priceFeed: '0xDaec4cC3a41E423d678428A8Bb29fa1ADF26869a',
            ltv: '65',
            liqThreshold: '75',
            liqBonus: '8.5',
            debtCeiling: '400000',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '400000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '9',
              variableRateSlope2: '75',
            },
            asset: '0xAD17Da2f6Ac76746EF261E835C50b2651ce36DA8',
            admin: '0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc',
          },
        ],
      },
      cache: {blockNumber: 53365321},
    },
  },
};
