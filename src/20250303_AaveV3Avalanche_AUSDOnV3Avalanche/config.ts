import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Avalanche'],
    title: 'AUSD on V3 Avalanche',
    shortName: 'AUSDOnV3Avalanche',
    date: '20250303',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-risk-parameters-update-ausd-on-v3-avalanche/21201',
    snapshot: 'direct-to-aip',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Avalanche: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'AUSD',
            ltv: '69',
            liqThreshold: '72',
            liqBonus: '6',
            debtCeiling: '0',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 58164409},
    },
  },
};
