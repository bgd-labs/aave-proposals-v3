import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'config.ts',
    author: 'Aavechan Initiative @aci',
    pools: ['AaveV3Ethereum'],
    title: 'Onboard Strata srUSDe PT tokens to V3 Core Instance',
    shortName: 'OnboardStrataSrUSDePTTokensToV3CoreInstance',
    date: '20260120',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-strata-srusde-pt-tokens-to-v3-core-instance/23481',
    snapshot:
      'https://snapshot.org/#/aavedao.eth/proposal/0x064b74d6b55b4cdabd6233555cf29e6fcc6118ed8c9050f1807c8db8525d7ae5',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '89.5',
            liqThreshold: '91.5',
            liqBonus: '4.5',
            label: 'PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC',
            collateralAssets: ['PT_srUSDe_2APR2026', 'sUSDe'],
            borrowableAssets: ['USDC', 'USDT', 'USDe'],
          },
          {
            ltv: '91.2',
            liqThreshold: '93.2',
            liqBonus: '2.6',
            label: 'PT_srUSDe_1APR2026_sUSDe__USDe',
            collateralAssets: ['PT_srUSDe_2APR2026', 'sUSDe'],
            borrowableAssets: ['USDe'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'PT_srUSDe_2APR2026',
            decimals: 18,
            priceFeed: '0xB539C6C0fc36ff1572B13ACec343B854937db576',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '50',
            supplyCap: '50000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x9Bf45ab47747F4B4dD09B3C2c73953484b4eB375',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 24278143},
    },
  },
};
