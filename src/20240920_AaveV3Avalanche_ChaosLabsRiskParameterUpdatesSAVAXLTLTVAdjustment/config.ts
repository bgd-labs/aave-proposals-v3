import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile:
      'src/20240920_AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment/config.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Avalanche'],
    title: 'Chaos Labs Risk Parameter Updates - sAVAX LT/LTV Adjustment',
    shortName: 'ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment',
    date: '20240920',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-savax-lt-ltv-adjustment/18995',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x79d53b646cbada43fca9468df9c9ecbbaab42f9f4f17691cbdf216b21f6c21bb',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Avalanche: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'sAVAX',
            ltv: '50',
            liqThreshold: '55',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3AvalancheEModes.AVAX_CORRELATED',
            ltv: '93',
            liqThreshold: '',
            liqBonus: '',
            priceSource: '',
            label: '',
          },
        ],
      },
      cache: {blockNumber: 50773736},
    },
  },
};
