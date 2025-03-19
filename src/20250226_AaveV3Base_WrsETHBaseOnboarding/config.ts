import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Base'],
    title: 'wrsETH Base Onboarding',
    shortName: 'WrsETHBaseOnboarding',
    date: '20250226',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-rseth-to-arbitrum-and-base-v3-instances/20741',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x598f7057f445813d75404fae68f3501d76c90064f52ca4b9afb6f20859fa2658',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 4,
            ltv: '92.5',
            liqThreshold: '94.5',
            liqBonus: '1',
            label: 'rsETH/wstETH emode',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'wrsETH',
            decimals: 18,
            priceFeed: '0x567E7f3DB2CD4C81872F829C8ab6556616818580',
            ltv: '0.05',
            liqThreshold: '0.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '400',
            borrowCap: '0',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '1',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            asset: '0xEDfa23602D0EC14714057867A78d01e94176BEA0',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 26891656},
    },
  },
};
