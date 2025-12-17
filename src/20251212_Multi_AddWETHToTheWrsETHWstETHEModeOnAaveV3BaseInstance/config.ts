import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Base'],
    title: 'Add WETH to the wrsETH wstETH E-Mode on Aave V3 Base Instance',
    shortName: 'AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance',
    date: '20251212',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-add-weth-to-the-wrseth-wsteth-e-mode-on-aave-v3-base-instance/23431',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'WETH',
            eModeCategory: 'AaveV3BaseEModes.RSETH_WSTETH',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
        ],
      },
      cache: {blockNumber: 39371067},
    },
  },
};
