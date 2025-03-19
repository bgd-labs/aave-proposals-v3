import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum', 'AaveV3Base'],
    title: 'Allow Balancer DAO to Claim Liquidity Mining Rewards',
    shortName: 'AllowBalancerDAOToClaimLiquidityMiningRewards',
    date: '20250318',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-whitelist-balancer-dao-to-claim-liquidity-mining-rewards-arbitrum-base/21280',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 69199111}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 27755124}},
  },
};
