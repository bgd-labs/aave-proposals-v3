import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum'],
    title: 'Enable SVR',
    shortName: 'EnableSVR',
    date: '20250312',
    discussion: 'https://governance.aave.com/t/arfc-aave-chainlink-svr-v1-phase-1-activation/21247',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0xe260268c607f20c85d1f93323f2f58b05f202916e0d3dbf55a8c335ed9be92da',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22030625}}},
};
