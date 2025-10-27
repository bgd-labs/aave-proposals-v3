import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Gnosis'],
    title: 'USDC (old) deprecation on Gnosis Chain Instance',
    shortName: 'USDCOldDeprecationOnGnosisChainInstance',
    date: '20251024',
    discussion:
      'https://governance.aave.com/t/arfc-usdc-old-deprecation-on-gnosis-chain-instance/23189',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x438b460559aa8c3a039f28212362af9a0e3b94a88e4a2b8230fe2c5e8f4d43da',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Gnosis: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '80',
            asset: 'USDC',
          },
        ],
        FREEZE: [{asset: 'USDC', shouldBeFrozen: true}],
      },
      cache: {blockNumber: 42786362},
    },
  },
};
