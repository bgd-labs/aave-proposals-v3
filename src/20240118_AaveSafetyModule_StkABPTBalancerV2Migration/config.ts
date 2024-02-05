import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveSafetyModule'],
    title: 'stkABPT Balancer V2 migration',
    shortName: 'StkABPTBalancerV2Migration',
    date: '20240118',
    discussion:
      'https://governance.aave.com/t/bgd-abpt-balancer-v2-migration-plan/8381/7#abpt-balancer-v1-v2-migration-update-1',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x33cdbe42706aa449c2e7d55d6c1e81da4bf3f153bb5c1010df71e8ab296fe525',
  },
  poolOptions: {AaveSafetyModule: {configs: {OTHERS: {}}, cache: {blockNumber: 19034613}}},
};
