import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Polygon', 'AaveV3Optimism', 'AaveV3Arbitrum', 'AaveV3Gnosis'],
    title: 'Chaos Labs Risk Parameter Updates AaveV3',
    shortName: 'ChaosLabsRiskParameterUpdatesAaveV3',
    date: '20240530',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-05-24-2024/17788',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x9674191acdb3cae244e010069df7637d6b7b3e30849f91570f0349323c5330d9',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Polygon: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'stMATIC',
            ltv: '48',
            liqThreshold: '58',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'MaticX',
            ltv: '50',
            liqThreshold: '60',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 57568503},
    },
    AaveV3Optimism: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'OP',
            ltv: '58',
            liqThreshold: '63',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 120739105},
    },
    AaveV3Arbitrum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'ARB',
            ltv: '58',
            liqThreshold: '63',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 216612699},
    },
    AaveV3Gnosis: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'GNO',
            ltv: '48',
            liqThreshold: '53',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 34209835},
    },
  },
};
