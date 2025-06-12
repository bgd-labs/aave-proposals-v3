import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250408_AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance/config.ts',
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3ZkSync'],
    title: 'Onboard wrsETH to ZKsync V3 Instance',
    shortName: 'OnboardWrsETHToZKsyncV3Instance',
    date: '20250408',
    discussion: 'https://governance.aave.com/t/arfc-onboard-wrseth-to-zksync-v3-instance/20727',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3ZkSync: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 3,
            ltv: '92.5',
            liqThreshold: '94.5',
            liqBonus: '1',
            label: 'wrsETH/wstETH',
          },
        ],
        EMODES_ASSETS: [
          {asset: 'wrsETH', eModeCategory: '3', collateral: 'ENABLED', borrowable: 'DISABLED'},
          {asset: 'wstETH', eModeCategory: '3', collateral: 'DISABLED', borrowable: 'ENABLED'},
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'wrsETH',
            decimals: 18,
            priceFeed: '0x8d25c9de6DBAd9a9eadfB2CA4706034F6721d555',
            ltv: '0.05',
            liqThreshold: '0.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '700',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x6bE2425C381eb034045b527780D2Bf4E21AB7236',
            admin: '0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc',
          },
        ],
      },
      cache: {blockNumber: 58835283},
    },
  },
};
