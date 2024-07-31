import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Tooling Update Allowance',
    shortName: 'ToolingUpdateAllowance',
    date: '20240707',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-treasury-management-tooling-upgrade/15201',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x461571b38365b12ebe39b80d4d9663daa9c7e574cd4bf190ec6fb48dec96371f',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20257930}}},
};
