import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum'],
    title: 'UmbrellaDeficitUpdates',
    shortName: 'UmbrellaDeficitUpdates',
    date: '20260313',
    discussion:
      'https://governance.aave.com/t/arfc-revenue-indexed-deficit-offsets-for-umbrella/24000',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0xfcd429c8fcb5fc44a0bea9bf078726ef48b1c76ca1039a8c6c9dff23f4547e30',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24645432}}},
};
