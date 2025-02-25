import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Extend GHO Steward on Aave Prime Instance',
    shortName: 'ExtendGHOStewardOnAavePrimeInstance',
    date: '20250129',
    author: 'TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-extend-gho-steward-on-aave-prime-instance/20598',
    snapshot:
      'https://snapshot.org/#/s:aave.eth/proposal/0xf28190a683eff1dc246924f150a724dcf29b23dd40971df38d20fc6cf301fbe1',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3EthereumLido: {configs: {OTHERS: {}}, cache: {blockNumber: 21738505}}},
};
