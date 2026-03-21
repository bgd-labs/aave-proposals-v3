import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Grant FUNDS_ADMIN role to Ink team',
    shortName: 'GrantFUNDS_ADMINRoleToInkTeam',
    date: '20260313',
    author: 'ACI',
  },
  poolOptions: {AaveV3InkWhitelabel: {configs: {OTHERS: {}}, cache: {blockNumber: 39929598}}},
};
