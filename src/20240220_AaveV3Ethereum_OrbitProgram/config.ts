import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Orbit Program',
    shortName: 'OrbitProgram',
    date: '20240220',
    author: 'karpatkey_TokenLogic_ACI',
    discussion: 'https://governance.aave.com/t/arfc-orbit-program-renewal/16550',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x412b38c7a0cf1840b102e28ea7ef0373e3ab4b9544873e8cc1544972b777d9a1',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19273121}}},
};
