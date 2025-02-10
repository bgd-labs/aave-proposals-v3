import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Prime Instance - Restore ETH LTV',
    shortName: 'PrimeInstanceRestoreETHLTV',
    date: '20250210',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-prime-instance-restore-eth-ltv/20933',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'WETH',
            ltv: '82',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'WETH',
            eModeCategory: 'AaveV3EthereumLidoEModes.ETH_CORRELATED',
            collateral: 'DISABLED',
            borrowable: 'KEEP_CURRENT',
          },
        ],
      },
      cache: {blockNumber: 21816550},
    },
  },
};
