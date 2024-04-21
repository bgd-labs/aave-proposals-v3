import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Optimism'],
    title: 'Risk Parameter Updates - OP on V3 Optimism',
    shortName: 'RiskParameterUpdatesOPOnV3Optimism',
    date: '20240415',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-op-on-v3-optimism/17326',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xbaaf99c1e738da5755166fc6b1429265243507fdb9638a31ca177dd81a8b7313',
  },
  poolOptions: {
    AaveV3Optimism: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'OP',
            ltv: '50',
            liqThreshold: '60',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 118786899},
    },
  },
};
