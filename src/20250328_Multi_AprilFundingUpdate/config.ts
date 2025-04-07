import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Polygon'],
    title: 'April Funding update',
    shortName: 'AprilFundingUpdate',
    date: '20250328',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-april-funding-update/21590',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {}, cache: {blockNumber: 22217011}},
    AaveV3Polygon: {configs: {}, cache: {blockNumber: 70007673}},
  },
};
