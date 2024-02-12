import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Retroactive Bug Bounty Pre-Immunefi',
    shortName: 'RetroactiveBugBountyPreImmunefi',
    date: '20240205',
    author: 'BGD Labs @bgdlabs',
    discussion:
      'https://governance.aave.com/t/bgd-retroactive-bug-bounties-proposal-pre-immunefi/15989',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xb707cff629af03eeaa44bbbb7e38def2907a53791eb16d472dac1d45fb5ec26b',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19162484}}},
};
