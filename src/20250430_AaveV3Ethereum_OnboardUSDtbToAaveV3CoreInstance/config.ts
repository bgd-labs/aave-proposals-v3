import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Onboard USDtb to Aave v3 Core Instance',
    shortName: 'OnboardUSDtbToAaveV3CoreInstance',
    date: '20250430',
    discussion: 'https://governance.aave.com/t/arfc-onboard-usdtb-to-aave-v3-core-instance/21746',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xf7ff963e0572d684bfd0c6d572a070d1b6ea60f4bcebbd6f68fc2af9c1e46659',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'USDtb',
            decimals: 18,
            priceFeed: '0x2FA6A78E3d617c1013a22938411602dc9Da98dBa',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '0',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '50000000',
            borrowCap: '40000000',
            rateStrategyParams: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '6',
              variableRateSlope2: '50',
            },
            asset: '0xC139190F447e929f090Edeb554D95AbB8b18aC1C',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 22384430},
    },
  },
};
