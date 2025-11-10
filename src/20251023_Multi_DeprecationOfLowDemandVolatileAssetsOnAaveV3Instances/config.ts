import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    title: 'Deprecation of Low Demand Volatile Assets on Aave V3 Instances',
    discussion:
      'https://governance.aave.com/t/arfc-deprecation-of-low-demand-volatile-assets-on-aave-v3-instances/23261',
    pools: ['AaveV3Ethereum', 'AaveV3Metis', 'AaveV3BNB', 'AaveV3ZkSync'],
    shortName: 'DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances',
    date: '20251023',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'CRV',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'BAL',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'UNI',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'LDO',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'ENS',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'ONE_INCH',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 23641967},
    },
    AaveV3Metis: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'Metis',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 21510561},
    },
    AaveV3BNB: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'Cake',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 65657815},
    },
    AaveV3ZkSync: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'ZK',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 65423730},
    },
  },
};
