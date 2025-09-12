import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Scroll'],
    title: 'Risk Parameter Adjustments for Aave V3 Scroll Instance',
    shortName: 'RiskParameterAdjustmentsForAaveV3ScrollInstance',
    date: '20250912',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-risk-parameter-adjustments-for-aave-v3-scroll-instance/23113',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Scroll: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '50',
            asset: 'WETH',
          },
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '50',
            asset: 'USDC',
          },
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '50',
            asset: 'wstETH',
          },
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '50',
            asset: 'weETH',
          },
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '50',
            asset: 'SCR',
          },
        ],
      },
      cache: {blockNumber: 21105921},
    },
  },
};
