import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Onboard PT-USDG 28MAY2026 on V3 Core',
    shortName: 'OnboardPTUSDG28MAY2026OnV3Core',
    date: '20260407',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-pt-usdg-28may2026-to-aave-v3-core-instance/24345/4',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0xaa29094accbcccd70088fb77dfd2800a4488319a0942b226c5699ea35d1c9e19',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'PT_USDG_28MAY2026',
            decimals: 6,
            priceFeed: '0x90498d4334259FA769830ccA9114D8bcF3745F6c',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '45',
            supplyCap: '80000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x9db38D74a0D29380899aD354121DfB521aDb0548',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
        EMODES_CREATION: [
          {
            ltv: '93.5',
            liqThreshold: '95.5',
            liqBonus: '2',
            label: 'PT_USDG_28MAY2026__Stablecoins',
            collateralAssets: ['PT_USDG_28MAY2026'],
            borrowableAssets: ['USDT', 'USDe', 'USDC', 'USDG'],
          },
        ],
      },
      cache: {blockNumber: 24829171},
    },
  },
};
