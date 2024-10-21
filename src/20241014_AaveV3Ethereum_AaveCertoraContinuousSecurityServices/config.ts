import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Aave <> Certora Continuous Security Services',
    shortName: 'AaveCertoraContinuousSecurityServices',
    date: '20241014',
    discussion:
      'https://governance.aave.com/t/arfc-aave-certora-continuous-security-services/19262',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xebf0b33be0c3784b2928112414f08e31ac57705f49d46668bfef6fa6f761141d',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20965854}}},
};
