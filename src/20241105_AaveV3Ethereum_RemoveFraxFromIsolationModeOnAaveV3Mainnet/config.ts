import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Remove Frax from Isolation Mode on Aave v3 Mainnet',
    shortName: 'RemoveFraxFromIsolationModeOnAaveV3Mainnet',
    date: '20241105',
    discussion:
      'https://governance.aave.com/t/arfc-remove-frax-from-isolation-mode-on-aave-v3-mainnet/19337',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x9bc3f3d8e38d70f55887f2f2498e1b39f59467489158923488aceab73cd4f144',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'FRAX',
            ltv: '0',
            liqThreshold: 'KEEP_CURRENT',
            liqBonus: 'KEEP_CURRENT',
            debtCeiling: '0',
            liqProtocolFee: 'KEEP_CURRENT',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: 'KEEP_CURRENT',
            asset: 'FRAX',
          },
        ],
      },
      cache: {blockNumber: 21123714},
    },
  },
};
