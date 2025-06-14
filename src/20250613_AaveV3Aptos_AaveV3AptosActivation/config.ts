import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'AaveV3AptosActivation',
    shortName: 'AaveV3AptosActivation',
    date: '20250613',
    author: 'Aave Labs',
    discussion: 'https://governance.aave.com/t/arfc-aave-events-sponsorship-budget-2025/22173',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x12ae50ccd9a4cd8edfead63d773e62ca23ea567a458c442557e0b6193e01bb1d',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22695142}}},
};
