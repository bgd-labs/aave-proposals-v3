import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Prime Instance - Restore ETH LTV',
    shortName: 'PrimeInstanceRestoreETHLTV',
    date: '20250210',
    author: 'TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-prime-instance-restore-eth-ltv/20933',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0xe7251459edae302517bc471776d82069afb13441b058c9fc989e0c878f13c873',
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
