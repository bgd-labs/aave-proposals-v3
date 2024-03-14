import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Scroll'],
    title: 'Activate Price Oracle Sentinel On Aave V3 Scroll',
    shortName: 'ActivatePriceOracleSentinelOnAaveV3Scroll',
    date: '20240314',
    author: 'BGD Labs',
    discussion: 'https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274',
    snapshot: '',
  },
  poolOptions: {AaveV3Scroll: {configs: {OTHERS: {}}, cache: {blockNumber: 4126179}}},
};
