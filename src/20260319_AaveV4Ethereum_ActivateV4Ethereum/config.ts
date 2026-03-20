import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV4Ethereum'],
    title: 'Activate V4 Ethereum',
    shortName: 'ActivateV4Ethereum',
    date: '20260319',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293',
    snapshot: 'TODO',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV4Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24693869}}},
};
