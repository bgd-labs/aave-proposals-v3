import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Merit Approvals',
    shortName: 'MeritApprovals',
    date: '20240306',
    author: 'karpatkey_TokenLogic_ACI',
    discussion:
      'https://governance.aave.com/t/arfc-merit-a-new-aave-alignment-user-reward-system/16646',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xc80da83fadfe4f8a4c56e1643895cb7e9b1af1d9dcd374f1b41ded5c95b42f68',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19377425}}},
};
