import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Chaos Labs x Aave DAO — Early Renewal Proposal',
    shortName: 'ChaosLabsXAaveDAOEarlyRenewalProposal',
    date: '20250625',
    discussion: 'https://governance.aave.com/t/chaos-labs-x-aave-dao-early-renewal-proposal/22346',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x9722b9690b52a159c0f6d9fb9fe805390031573d87e89a77fe90888f27ab0c3c',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22779766}}},
};
