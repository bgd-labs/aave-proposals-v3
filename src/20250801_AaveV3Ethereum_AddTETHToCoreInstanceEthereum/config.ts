import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Add tETH to Core Instance Ethereum',
    shortName: 'AddTETHToCoreInstanceEthereum',
    date: '20250801',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-add-teth-to-core-instance-ethereum/22594/3',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '72',
            liqThreshold: '75',
            liqBonus: '7.5',
            label: 'tETH/Stablecoins',
            collateralAssets: ['tETH'],
            borrowableAssets: ['USDC', 'USDT'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'tETH',
            decimals: 18,
            priceFeed: '0x85968026294b8f8Fb86d6bF3Cda079f9376aD05A',
            ltv: '.05',
            liqThreshold: '.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '10000',
            borrowCap: '0',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
            },
            asset: '0xD11c452fc99cF405034ee446803b6F6c1F6d5ED8',
            admin: '',
          },
        ],
      },
      cache: {blockNumber: 23046913},
    },
  },
};
