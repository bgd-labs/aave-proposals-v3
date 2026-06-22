import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Labs',
    pools: ['AaveV4Ethereum'],
    title: 'Onboard PT-USDG-24SEP2026 on V4 Paxos Hub / USDG Pendle',
    shortName: 'OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle',
    date: '20260514',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-pt-usdg-24sep2026-to-aave-v4-on-ethereum/24942/3',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV4Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25318221}}},
};
