import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Update FEB sUSDe PT e-modes',
    shortName: 'UpdateFEBSUSDePTEModes',
    date: '20251205',
    author: 'Chaos Labs (implemented by ACI via Skyward)',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-ethena-february-pts-caps-and-e-modes-adjustments/23501',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'sUSDe',
            eModeCategory:
              'AaveV3EthereumEModes.PT_sUSDE_27NOV2025_PT_sUSDE_5FEB2026__USDC_USDT_USDe_USDtb',
            collateral: 'ENABLED',
            borrowable: 'KEEP_CURRENT',
          },
          {
            asset: 'sUSDe',
            eModeCategory: 'AaveV3EthereumEModes.PT_sUSDE_27NOV2025_PT_sUSDE_5FEB2026__USDe',
            collateral: 'ENABLED',
            borrowable: 'KEEP_CURRENT',
          },
        ],
      },
      cache: {blockNumber: 23944191},
    },
  },
};
