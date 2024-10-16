import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Increase USDS Borrow Rate to Match Sky Savings Rate',
    shortName: 'IncreaseUSDSBorrowRateToMatchSkySavingsRate',
    date: '20241016',
    discussion:
      'https://governance.aave.com/t/arfc-increase-usds-borrow-rate-to-match-sky-savings-rate/19494',
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
              baseVariableBorrowRate: '6.25',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 20980031},
    },
  },
};
