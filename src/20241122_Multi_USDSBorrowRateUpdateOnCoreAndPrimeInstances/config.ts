import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20241122_Multi_IncreaseUSDSCoreAndPrimeInstanceBaseRateTo825/config.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido'],
    title: 'USDS borrow rate update on Core and Prime Instances',
    shortName: 'USDSBorrowRateUpdateOnCoreAndPrimeInstances',
    date: '20241122',
    discussion:
      'https://governance.aave.com/t/arfc-usds-borrow-rate-update-on-core-and-prime-instances/19901',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDS',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '9.25',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 21243091},
    },
    AaveV3EthereumLido: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDS',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.25',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 21243125},
    },
  },
};
