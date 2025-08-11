import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Linea'],
    title: 'Onboard rsETH to Aave V3 Linea Instance',
    shortName: 'OnboardRsETHToAaveV3LineaInstance',
    date: '20250811',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-rseth-to-aave-v3-linea-instance/22172',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Linea: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '90',
            liqThreshold: '93',
            liqBonus: '1',
            label: 'wrsETH/WETH Isolated Liquid E-mode',
            collateralAssets: [],
            borrowableAssets: ['WETH'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'wrsETH',
            decimals: 18,
            priceFeed: '0x444f25c5E73fED92B91F3ECB1bD27003C3CDdeE7',
            ltv: '70',
            liqThreshold: '73',
            liqBonus: '10',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '45',
            supplyCap: '400',
            borrowCap: '0',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '20',
              variableRateSlope2: '300',
            },
            asset: '0xD2671165570f41BBB3B0097893300b6EB6101E6C',
            admin: '0xdef1FA4CEfe67365ba046a7C630D6B885298E210',
          },
        ],
      },
      cache: {blockNumber: 21914675},
    },
  },
};
