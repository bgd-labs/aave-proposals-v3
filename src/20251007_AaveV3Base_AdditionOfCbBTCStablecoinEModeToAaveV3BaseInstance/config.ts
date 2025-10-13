import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Base'],
    title: 'Addition of cbBTC/Stablecoin E-Mode to Aave V3 Base Instance',
    shortName: 'AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance',
    date: '20251007',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-addition-of-cbbtc-stablecoin-e-mode-to-aave-v3-base-instance/23174',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '80',
            liqThreshold: '83',
            liqBonus: '4',
            label: 'cbBTC Stablecoins',
            collateralAssets: ['cbBTC'],
            borrowableAssets: ['USDC', 'GHO'],
          },
        ],
      },
      cache: {blockNumber: 36535639},
    },
  },
};
