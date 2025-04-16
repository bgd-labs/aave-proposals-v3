import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Avalanche'],
    title: 'Aave Governance technical maintenance',
    shortName: 'AaveGovernanceTechnicalMaintenance',
    date: '20250317',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 22067248}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 69163036}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 58854210}},
  },
};
