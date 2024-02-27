import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title:
      'Chaos Labs Risk Parameter Updates - Increase Debt Ceiling for SNX and MKR on V3 Ethereum - 01.31.2024',
    shortName: 'ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024',
    date: '20240211',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-debt-ceiling-for-snx-and-mkr-on-v3-ethereum-01-31-2024/16480/1',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xe1a36b7daaf5ab8555510edf53fc75645c7a0ac26b3d47cfe9295b94f96bcf3a',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'MKR',
            ltv: '',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '12_000_000',
            liqProtocolFee: '',
          },
          {
            asset: 'SNX',
            ltv: '',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '4_000_000',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 19204803},
    },
  },
};
