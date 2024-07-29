import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum'],
    title: 'GHO Flash Minter Facilitator Arbitrum',
    shortName: 'GHOFlashMinterFacilitatorArbitrum',
    date: '20240727',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-gho-flash-minter-facilitator-arbitrum/18445',
    snapshot: 'TODO',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 236414103}}},
};
