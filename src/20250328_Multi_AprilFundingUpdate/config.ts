import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Arbitrum',
      'AaveV3Base',
      'AaveV3Sonic',
    ],
    title: 'April Funding update',
    shortName: 'AprilFundingUpdate',
    date: '20250328',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-april-funding-update/21590',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {}, cache: {blockNumber: 22145727}},
    AaveV3Polygon: {configs: {}, cache: {blockNumber: 69604711}},
    AaveV3Arbitrum: {configs: {}, cache: {blockNumber: 321985871}},
    AaveV3Base: {configs: {}, cache: {blockNumber: 28189359}},
  },
};
