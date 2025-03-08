import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'GSMs Migration to GSM4626',
    shortName: 'GSMsMigrationToGSM4626',
    date: '20250114',
    author: 'TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-deploy-statausdc-and-statausdt-gsms-on-ethereum/20682',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x82d3ad8b8d43b12d3c08344c9b3aadfa6da03b358aa92915d0046f19344a7faa',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21938030}}},
};
