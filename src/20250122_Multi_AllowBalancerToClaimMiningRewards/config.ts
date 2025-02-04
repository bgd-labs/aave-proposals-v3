import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Gnosis'],
    title: 'Allow Balancer To Claim Mining Rewards',
    shortName: 'AllowBalancerToClaimMiningRewards',
    date: '20250122',
    author: '@TokenLogic, @BGDLabs',
    discussion:
      'https://governance.aave.com/t/arfc-whitelist-balancer-dao-to-claim-liquidity-mining-rewards/20653',
    snapshot:
      'https://snapshot.org/#/s:aave.eth/proposal/0x054d40462303edd7e3a3c90b945a187e037cf412751631e9b01ba536acbdd40b',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21680887}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 38172377}},
  },
};
