import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Celo'],
    title: ' Onboarding wETH to Aave V3 Celo Instance',
    shortName: 'OnboardingWETHToAaveV3CeloInstance',
    date: '20250515',
    discussion: 'https://governance.aave.com/t/arfc-onboarding-weth-to-aave-v3-celo-instance/21750',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xcf4e56350b6dc4615f4206a02d41c8f5958bc9a71594bed975e2657c9bc0b9b8',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Celo: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'WETH',
            decimals: 18,
            priceFeed: '0x1FcD30A73D67639c1cD89ff5746E7585731c083B',
            ltv: '78',
            liqThreshold: '80',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'ENABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '500',
            borrowCap: '450',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '2.7',
              variableRateSlope2: '80',
            },
            asset: '0xD221812de1BD094f35587EE8E174B07B6167D9Af',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 35444298},
    },
  },
};
