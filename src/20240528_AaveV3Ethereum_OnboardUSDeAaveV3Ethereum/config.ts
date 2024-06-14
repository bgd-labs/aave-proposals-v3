import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20240528_AaveV3Ethereum_OnboardUSDeAaveV3Ethereum/config.ts',
    pools: ['AaveV3Ethereum'],
    title: 'Onboard USDe Aave V3 Ethereum',
    shortName: 'OnboardUSDeAaveV3Ethereum',
    date: '20240528',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-onboard-usde-to-aave-v3-on-ethereum/17690',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xc1b6d0d390a2dabf81206f592f740c69163dd028dcb0f50182d0ad3a50e744b0',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'USDe',
            decimals: 18,
            priceFeed: '0x55B6C4D3E8A27b8A1F5a263321b602e0fdEEcC17',
            ltv: '72',
            liqThreshold: '75',
            liqBonus: '8.5',
            debtCeiling: '40000000',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'ENABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '25',
            supplyCap: '80000000',
            borrowCap: '72000000',
            rateStrategyParams: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '9',
              variableRateSlope2: '75',
              stableRateSlope1: '9',
              stableRateSlope2: '75',
              baseStableRateOffset: '0',
              stableRateExcessOffset: '0',
              optimalStableToTotalDebtRatio: '0',
            },
            eModeCategory: 'AaveV3EthereumEModes.NONE',
            asset: '0x4c9edd5852cd905f086c759e8383e09bff1e68b3',
          },
        ],
      },
      cache: {blockNumber: 19967375},
    },
  },
};
