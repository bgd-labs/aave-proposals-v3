import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum'],
    title: 'Aave v3.3 Sherlock contest funding',
    shortName: 'AaveV33SherlockContestFunding',
    date: '20250106',
    discussion: 'https://governance.aave.com/t/arfc-bgd-aave-v3-3-sherlock-contest/20498',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x8c04404012d9b74c3e7cebff2ddff3c9d40a280b4cfa7c2fca42be2a59b005ee',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21566088}}},
};
