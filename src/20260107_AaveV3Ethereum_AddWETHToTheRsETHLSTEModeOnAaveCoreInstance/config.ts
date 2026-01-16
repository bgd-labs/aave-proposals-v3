import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'TTT (implemented by Aavechan Initiative @aci via Skyward)',
    pools: ['AaveV3Ethereum'],
    title: 'Add WETH to the rsETH LST E-Mode on Aave Core Instance ',
    shortName: 'AddWETHToTheRsETHLSTEModeOnAaveCoreInstance',
    date: '20260107',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-add-weth-to-the-rseth-lst-e-mode-on-aave-core-instance/23425',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3EthereumEModes.rsETH__wstETH_ETHx',
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '1',
            label: 'rsETH__ETHx_wstETH_ETHx',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'WETH',
            eModeCategory: 'AaveV3EthereumEModes.rsETH__wstETH_ETHx',
            collateral: 'KEEP_CURRENT',
            borrowable: 'ENABLED',
          },
        ],
      },
      cache: {blockNumber: 24183624},
    },
  },
};
