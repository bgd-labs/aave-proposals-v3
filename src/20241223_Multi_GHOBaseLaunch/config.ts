import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum', 'AaveV3Base'],
    title: 'GHO Base Launch',
    shortName: 'GHOBaseLaunch',
    date: '20241223',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/arfc-launch-gho-on-base-set-aci-as-emissions-manager-for-rewards/19338',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x03dc21e0423c60082dc23317af6ebaf997610cbc2cbb0f5a385653bd99a524fe',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 21463360}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 288070365}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 24072751}},
  },
};
