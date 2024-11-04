import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Fix USDS Borrow Rate to Match Sky Savings Rate',
    shortName: 'FixUSDSBorrowRateToMatchSkySavingsRate',
    date: '20241022',
    author: 'ACI',
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
              baseVariableBorrowRate: '',
              variableRateSlope1: '0.75',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 21021725},
    },
  },
};
