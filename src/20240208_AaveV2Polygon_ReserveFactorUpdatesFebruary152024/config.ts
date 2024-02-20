import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Polygon'],
    title: 'Reserve Factor Updates (February 15, 2024)',
    shortName: 'ReserveFactorUpdatesFebruary152024',
    date: '20240208',
    author: 'karpatkey_TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/16',
    snapshot: 'No snapshot for Direct-to-AIP',
  },
  poolOptions: {AaveV2Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 53283615}}},
};
