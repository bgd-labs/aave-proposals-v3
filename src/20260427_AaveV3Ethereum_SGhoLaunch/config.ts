import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'sGho Launch',
    shortName: 'SGhoLaunch',
    date: '20260427',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-sgho-launch-configuration/24346',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xb9e9b01efcf6151bade78546d0f51f11d7961939b649fb7717e82ea3d43d4f47',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25029360}}},
};
