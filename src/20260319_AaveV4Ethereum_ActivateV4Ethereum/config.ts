import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV4Ethereum'],
    title: 'Aave V4 Activation on Ethereum Mainnet',
    shortName: 'ActivateV4Ethereum',
    date: '20260319',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0x55e85a32828da36122b9c8d50548696d7c748fd41c775f5bf06bdf0f2e32a265',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV4Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24693869}}},
};
