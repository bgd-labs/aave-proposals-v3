import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Manual Risk Stewards Activation',
    shortName: 'ManualRiskStewardsActivation',
    date: '20260119',
    author: 'BGD Labs (@bgdlabs)',
  },
  poolOptions: {AaveV3InkWhitelabel: {configs: {OTHERS: {}}, cache: {blockNumber: 35296796}}},
};
