import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250326_AaveV3Arbitrum_OnboardRsETHToArbitrum/config.ts',
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Arbitrum'],
    title: ' Onboard rsETH to Arbitrum',
    shortName: 'OnboardRsETHToArbitrum',
    date: '20250326',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-rseth-to-arbitrum-and-base-v3-instances/20741',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x598f7057f445813d75404fae68f3501d76c90064f52ca4b9afb6f20859fa2658',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Arbitrum: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 5,
            ltv: '92.5',
            liqThreshold: '94.5',
            liqBonus: '1',
            label: 'rsETH/wstETH emode',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'rsETH',
            decimals: 18,
            priceFeed: '0xb4B0cbcA864c2Eb0C0342608D92490C034aC1089',
            ltv: '.05',
            liqThreshold: '.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '900',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x4186BFC76E2E237523CBC30FD220FE055156b41F',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 69536140},
    },
  },
};
