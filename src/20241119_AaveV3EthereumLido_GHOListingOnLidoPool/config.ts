import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'BGD Labs @bgdlabs',
    pools: ['AaveV3EthereumLido'],
    title: 'GHO listing on Lido pool',
    shortName: 'GHOListingOnLidoPool',
    date: '20241119',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'GHO',
            decimals: 18,
            priceFeed: '0xD110cac5d8682A3b045D5524a9903E031d70FCCd',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '20',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '0',
            supplyCap: '2000000',
            borrowCap: '2000000',
            rateStrategyParams: {
              optimalUtilizationRate: '100',
              baseVariableBorrowRate: '4',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
            },
            asset: '0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f',
            admin: '',
          },
        ],
      },
      cache: {blockNumber: 21223745},
    },
  },
};
