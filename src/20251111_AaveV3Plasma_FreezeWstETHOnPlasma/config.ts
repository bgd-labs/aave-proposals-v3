import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Plasma'],
    title: 'Freeze wstETH on Plasma',
    shortName: 'FreezeWstETHOnPlasma',
    date: '20251111',
    author: 'Lido (implemented by ACI via Skyward)',
    discussion: 'https://governance.aave.com/t/direct-to-aip-freeze-wsteth-on-plasma/23400',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Plasma: {
      configs: {FREEZE: [{asset: 'wstETH', shouldBeFrozen: true}]},
      cache: {blockNumber: 5968287},
    },
  },
};
