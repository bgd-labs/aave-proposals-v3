import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Activation of A-C Prime Foundation',
    shortName: 'ActivationOfACPrimeFoundation',
    date: '20240308',
    author: '@Khan',
    discussion: 'https://governance.aave.com/t/arfc-aave-treasury-rwa-allocation/14790',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x71db494e4b49e7533c5ccaa566686b2d045b0761cb3296a2d77af4b500566eb0',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19390425}}},
};
