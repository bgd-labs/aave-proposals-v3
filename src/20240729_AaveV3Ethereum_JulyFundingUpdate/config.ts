import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'July Funding Update',
    shortName: 'JulyFundingUpdate',
    date: '20240729',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-july-funding-update/18447',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20421735}}},
};
