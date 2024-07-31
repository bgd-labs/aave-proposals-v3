import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20240717_AaveV3Gnosis_OnboardUSDCEOnGnosis/config.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Gnosis'],
    title: 'Onboard USDC.e on Gnosis',
    shortName: 'OnboardUSDCEOnGnosis',
    date: '20240717',
    discussion: 'https://governance.aave.com/t/arfc-onboard-usdc-e-to-aave-v3-gnosis-chain/17948/3',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xefdd7d915acc3a179c756295ad6583645dfc491424cda08916e80c8551e30943',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Gnosis: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'USDCe',
            decimals: 6,
            priceFeed: '0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'ENABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '1500000',
            borrowCap: '1400000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '9',
              variableRateSlope2: '75',
              stableRateSlope1: '9',
              stableRateSlope2: '75',
              baseStableRateOffset: '00',
              stableRateExcessOffset: '0',
              optimalStableToTotalDebtRatio: '0',
            },
            eModeCategory: 'AaveV3GnosisEModes.NONE',
            asset: '0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0',
          },
        ],
      },
      cache: {blockNumber: 35231842},
    },
  },
};
