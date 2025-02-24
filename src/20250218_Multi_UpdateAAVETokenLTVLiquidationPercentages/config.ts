import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum'],
    title: 'Update AAVE Token LTV/Liquidation Percentages',
    shortName: 'UpdateAAVETokenLTVLiquidationPercentages',
    date: '20250218',
    discussion:
      'https://governance.aave.com/t/arfc-update-aave-token-ltv-liquidation-percentages/20973',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x50d01665cddf8ea977051cf6de8534cd37b107be52e863e168a8ece2ea4b544f',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'AAVE',
            ltv: '69',
            liqThreshold: '76',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 21876392},
    },
    AaveV3Arbitrum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'AAVE',
            ltv: '66',
            liqThreshold: '73',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 68091487},
    },
  },
};
