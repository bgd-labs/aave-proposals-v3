import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum'],
    title: 'Upgrade AMPL implementation',
    shortName: 'UpgradeAMPLImplementation',
    date: '20240402',
    author: 'BGD Labs',
    discussion: 'https://governance.aave.com/t/arfc-aampl-interim-distribution/17184',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xb7226dd6441b67225924082215f7a512bfd98252897ee43a879084e07ab53607',
  },
  poolOptions: {AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19568854}}},
};
