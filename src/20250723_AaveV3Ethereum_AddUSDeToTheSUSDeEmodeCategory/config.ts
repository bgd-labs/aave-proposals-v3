import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Add USDe to the sUSDe emode Category',
    shortName: 'AddUSDeToTheSUSDeEmodeCategory',
    date: '20250723',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-add-usde-to-the-susde-emode-category/22657',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'USDe',
            eModeCategory: 'AaveV3EthereumEModes.SUSDE_STABLECOINS',
            collateral: 'ENABLED',
            borrowable: 'KEEP_CURRENT',
          },
        ],
      },
      cache: {blockNumber: 22983987},
    },
  },
};
