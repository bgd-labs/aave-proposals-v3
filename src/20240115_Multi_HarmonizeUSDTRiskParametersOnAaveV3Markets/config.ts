import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Metis',
    ],
    title: 'Harmonize USDT Risk Parameters on Aave V3 Markets',
    shortName: 'HarmonizeUSDTRiskParametersOnAaveV3Markets',
    date: '20240115',
    author: 'Aave Chan Initiative',
    discussion:
      'https://governance.aave.com/t/arfc-harmonize-usdt-risk-parameters-on-aave-v3-markets/15815',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x285c3f9ef8ae3e0286ce18b45dc7605174c3fb61edf1df34ed5d8f5aa621ab9d',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'USDT',
            ltv: '77',
            liqThreshold: '80',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 19015350},
    },
    AaveV3Polygon: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'USDT',
            ltv: '77',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 52368898},
    },
    AaveV3Avalanche: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'USDt',
            ltv: '77',
            liqThreshold: '80',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 40413492},
    },
    AaveV3Optimism: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'USDT',
            ltv: '77',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 114880201},
    },
    AaveV3Arbitrum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'USDT',
            ltv: '77',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 170839641},
    },
    AaveV3Metis: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'mUSDT',
            ltv: '77',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 11029188},
    },
  },
};
