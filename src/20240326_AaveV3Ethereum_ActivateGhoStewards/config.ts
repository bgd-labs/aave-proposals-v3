import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Activate Gho Stewards',
    shortName: 'ActivateGhoStewards',
    date: '20240326',
    author: 'Aave Chan Initiative',
    discussion: 'https://governance.aave.com/t/arfc-gho-stewards-borrow-rate-update/16956',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x29f63b24638ee822f88632572ca4b061774771c0cc6d0ae5ccdeb538177232cd',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19519644}}},
};
