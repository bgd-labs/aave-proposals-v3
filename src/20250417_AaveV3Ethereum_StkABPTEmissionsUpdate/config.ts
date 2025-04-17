import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'stkABPT - Emissions Update',
    shortName: 'StkABPTEmissionsUpdate',
    date: '20250417',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-stkabpt-emissions-update/21683',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x8dbeee9b489266cfefb8cb3c75fb0791d364975eed48cee951ff04fd17ee57c1',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 22288815}}},
};
