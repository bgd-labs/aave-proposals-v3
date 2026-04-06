import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Aave DAO <> BGD Labs. 2-month security retainer',
    shortName: 'AaveDAOBGDLabs2MonthSecurityRetainer',
    date: '20260406',
    author: 'BGD Labs (@bgdlabs)',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-aave-dao-bgd-labs-2-month-security-retainer/24385',
    snapshot: 'Direct To AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24820179}}},
};
