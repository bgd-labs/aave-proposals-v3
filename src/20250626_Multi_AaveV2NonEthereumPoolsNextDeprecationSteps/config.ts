import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Polygon', 'AaveV2Avalanche'],
    title: 'Aave v2 non-Ethereum pools next deprecation steps',
    shortName: 'AaveV2NonEthereumPoolsNextDeprecationSteps',
    date: '20250626',
    author: 'BGD Labs (@bgdlabs)',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-aave-v2-non-ethereum-pools-next-deprecation-steps/22445',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV2Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 73234716}},
    AaveV2Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 64488687}},
  },
};
