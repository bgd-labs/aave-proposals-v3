import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250311_AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance/config.ts',
    force: true,
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Gnosis'],
    title: 'Enhancements in Aave v3 Gnosis Chain Instance',
    shortName: 'EnhancementsInAaveV3GnosisChainInstance',
    date: '20250311',
    discussion:
      'https://governance.aave.com/t/arfc-enhancements-in-aave-v3-gnosis-chain-instance/21214',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x27b21aa2cd21d5e94eb9b9e0232fe875ad45719588ada4b059f67a8834d7408e',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Gnosis: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'sDAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '20',
            },
          },
        ],
        COLLATERALS_UPDATE: [
          {
            asset: 'USDC',
            ltv: '65',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
        BORROWS_UPDATE: [
          {
            asset: 'USDC',
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '40',
          },
        ],
        CAPS_UPDATE: [
          {asset: 'USDC', supplyCap: '2500000', borrowCap: '2000000'},
          {asset: 'sDAI', supplyCap: '', borrowCap: '4000000'},
        ],
        EMODES_UPDATES: [
          {eModeCategory: 3, ltv: '90', liqThreshold: '92', liqBonus: '4', label: 'sDAI_USDCe'},
        ],
        EMODES_ASSETS: [
          {asset: 'USDCe', eModeCategory: '3', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {asset: 'sDAI', eModeCategory: '3', collateral: 'ENABLED', borrowable: 'DISABLED'},
        ],
      },
      cache: {blockNumber: 38986299},
    },
  },
};
