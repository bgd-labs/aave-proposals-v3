import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Funding Update (Part B)',
    shortName: 'FundingUpdatePartB',
    date: '20240324',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-funding-update/16675/4',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x4dd4dff7096bf7ab8c4c071975d40f4cf709c41b4b6b7c60777a6dd50d2ecd09',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19504819}}},
};
