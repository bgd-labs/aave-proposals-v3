import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3BNB',
      'AaveV3Scroll',
    ],
    title: 'Generalized LT/LTV Reduction on Aave',
    shortName: 'GeneralizedLTLTVReductionOnAave',
    date: '20240324',
    author: 'Chaos Labs',
    discussion: 'https://governance.aave.com/t/generalized-lt-ltv-reduction-on-aave/16766',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x4067d91ef5864925136d10ec9419f032a70f7e6489740386e348488426656274',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'USDC',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'DAI',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDT',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'sDAI',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 19418547},
    },
    AaveV3Polygon: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'DAI',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDC',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDT',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDCn',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 55027261},
    },
    AaveV3Avalanche: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'DAIe',
            ltv: '',
            liqThreshold: '80',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDC',
            ltv: '80',
            liqThreshold: '85',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDt',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 43314428},
    },
    AaveV3Optimism: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'DAI',
            ltv: '75',
            liqThreshold: '80',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDC',
            ltv: '78',
            liqThreshold: '84',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDT',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDCn',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 117843625},
    },
    AaveV3Arbitrum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'DAI',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDC',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDT',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDCn',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 193722981},
    },
    AaveV3Base: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'USDbC',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDC',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 12248413},
    },
    AaveV3Gnosis: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'USDC',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'WXDAI',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'sDAI',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 33091789},
    },
    AaveV3BNB: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'USDC',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
          {
            asset: 'USDT',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 37073128},
    },
    AaveV3Scroll: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'USDC',
            ltv: '76',
            liqThreshold: '79',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 4388533},
    },
  },
};
