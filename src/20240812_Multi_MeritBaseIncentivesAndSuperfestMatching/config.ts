import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20240812_Multi_MeritBaseIncentivesAndSuperfestMatching/config.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum', 'AaveV3Base'],
    title: 'Merit Base Incentives and Superfest Matching',
    shortName: 'MeritBaseIncentivesAndSuperfestMatching',
    date: '20240812',
    discussion:
      'https://governance.aave.com/t/arfc-merit-base-incentives-and-superfest-matching/18450',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x15cbc6b6c5b4ef76a1fb8cf8747460bf327c459fa01b69907fab0119457939a8',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20514462}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 18354993}},
  },
};
