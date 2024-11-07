import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    title: 'GHO Avax Launch',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards/19339',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719',
    pools: ['AaveV3Ethereum', 'AaveV3Avalanche', 'AaveV3Arbitrum'],
    shortName: 'GHOAvaxLaunch',
    date: '20241106',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21133428}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 52758592}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 271862002}},
  },
};
