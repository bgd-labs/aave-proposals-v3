import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido'],
    title: 'Proposal to Remove USDS from sUSDe Liquid E-Mode in Aave Prime Instance',
    shortName: 'ProposalToRemoveUSDSFromSUSDeLiquidEModeInAavePrimeInstance',
    date: '20241224',
    discussion:
      'https://governance.aave.com/t/arfc-proposal-to-remove-usds-from-susde-liquid-e-mode-in-aave-prime-instance/20264',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x2be035a75fb8c5bb4e99e56006e57b7eb7df8bdd5616d903309ef6fc5b7446de',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3EthereumEModes.SUSDE_STABLECOINS',
            ltv: '',
            liqThreshold: '',
            liqBonus: '4',
            label: '',
          },
        ],
      },
      cache: {blockNumber: 21474019},
    },
    AaveV3EthereumLido: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3EthereumLidoEModes.SUSDE_STABLECOINS',
            ltv: '',
            liqThreshold: '',
            liqBonus: '4',
            label: '',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'USDS',
            eModeCategory: 'AaveV3EthereumLidoEModes.SUSDE_STABLECOINS',
            collateral: 'KEEP_CURRENT',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 21474028},
    },
  },
};
