import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Onboard sUSDe to Aave V3 on Ethereum',
    shortName: 'OnboardSUSDeToAaveV3OnEthereum',
    date: '20240621',
    discussion: 'https://governance.aave.com/t/arfc-onboard-susde-to-aave-v3-on-ethereum/17191',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x9c6dcf2af7d79467f34e52b505c25d5e4c89af77f00396307d42fc4816797cd9',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'sUSDe',
            decimals: 18,
            priceFeed: '0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A',
            ltv: '72',
            liqThreshold: '75',
            liqBonus: '8.5',
            debtCeiling: '40000000',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '85000000',
            borrowCap: '0',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
              stableRateSlope1: '0',
              stableRateSlope2: '0',
              baseStableRateOffset: '0',
              stableRateExcessOffset: '0',
              optimalStableToTotalDebtRatio: '0',
            },
            eModeCategory: 'AaveV3EthereumEModes.NONE',
            asset: '0x9D39A5DE30e57443BfF2A8307A4256c8797A3497',
          },
        ],
      },
      cache: {blockNumber: 20142490},
    },
  },
};
