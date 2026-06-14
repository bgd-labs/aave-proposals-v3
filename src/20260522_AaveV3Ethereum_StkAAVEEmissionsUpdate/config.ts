import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'stkAAVE Emissions Update',
    shortName: 'StkAAVEEmissionsUpdate',
    date: '20260522',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-stkaave-emissions-update/24945',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0xd416e6cb09416cc4effdd2ad869373db2ac005ea63e7d7baeec0db4934281352',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 25152670}}},
};
