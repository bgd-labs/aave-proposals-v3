import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Chaos Labs',
    pools: ['AaveV2Ethereum'],
    title: 'AMPL Interest Rate Updates on V2 Ethereum',
    discussion:
      'https://governance.aave.com/t/arfc-ampl-interest-rate-updates-on-v2-ethereum/16189',
    snapshot:
      'https://snapshot.org/\\#/aave.eth/proposal/0xc5373ecc51b9ce6a568f2bb99181cf34efb3f317a4bd340719bc10c864fd1332',
    shortName: 'AMPLInterestRateUpdatesOnV2Ethereum',
    date: '20240121',
  },
  poolOptions: {
    AaveV2Ethereum: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'AMPL',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '0',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 19055881},
    },
  },
};
