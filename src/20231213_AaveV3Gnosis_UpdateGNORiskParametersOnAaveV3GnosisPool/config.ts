import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Gnosis'],
    title: 'Update GNO Risk Parameters on Aave V3 Gnosis Pool',
    shortName: 'UpdateGNORiskParametersOnAaveV3GnosisPool',
    date: '20231213',
    author: ' Aave Chan Initiative',
    discussion:
      'https://governance.aave.com/t/arfc-update-gno-risk-parameters-on-aave-v3-gnosis-pool/15613',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xe35faf498e25ff6a0620b8395c4653b05fe98cb0ccaacb62da140e53097f9ac0',
  },
  poolOptions: {
    AaveV3Gnosis: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'GNO',
            params: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '15',
              variableRateSlope2: '80',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
        CAPS_UPDATE: [{asset: 'GNO', supplyCap: '', borrowCap: '1100'}],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'ENABLED',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            asset: 'GNO',
          },
        ],
      },
      cache: {blockNumber: 31425108},
    },
  },
};
