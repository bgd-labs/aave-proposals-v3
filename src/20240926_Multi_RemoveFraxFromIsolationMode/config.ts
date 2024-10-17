import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum', 'AaveV3Avalanche', 'AaveV3Arbitrum'],
    title: 'Remove Frax from Isolation Mode',
    shortName: 'RemoveFraxFromIsolationMode',
    date: '20240926',
    discussion:
      'https://governance.aave.com/t/arfc-remove-frax-from-isolation-mode-and-onboard-sfrax-to-aave-v3-mainnet/18506',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x89f056f633646ee0676e226da41e2c6a7df756a7087204a96db8c3d74427244a',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '92',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '60',
            },
          },
        ],
        COLLATERALS_UPDATE: [
          {
            asset: 'FRAX',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '4.5',
            debtCeiling: '0',
            liqProtocolFee: '20',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '15',
            asset: 'FRAX',
          },
        ],
      },
      cache: {blockNumber: 20836233},
    },
    AaveV3Avalanche: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '60',
            },
          },
        ],
        COLLATERALS_UPDATE: [
          {
            asset: 'FRAX',
            ltv: '75',
            liqThreshold: '81',
            liqBonus: '4',
            debtCeiling: '0',
            liqProtocolFee: '',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '15',
            asset: 'FRAX',
          },
        ],
      },
      cache: {blockNumber: 51028150},
    },
    AaveV3Arbitrum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '60',
            },
          },
        ],
        COLLATERALS_UPDATE: [
          {
            asset: 'FRAX',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '5',
            debtCeiling: '0',
            liqProtocolFee: '',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '15',
            asset: 'FRAX',
          },
        ],
      },
      cache: {blockNumber: 257618568},
    },
  },
};
