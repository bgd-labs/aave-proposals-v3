import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Onboard GHO and Migrate Streams to Lido Instance',
    shortName: 'OnboardGHOAndMigrateStreamsToLidoInstance',
    date: '20241104',
    author: 'karpatkey_TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-gho-and-migrate-streams-to-lido-instance/19686',
    snapshot: 'TBD',
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
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '0.01',
            supplyCap: '11000000',
            borrowCap: '10000000',
            rateStrategyParams: {
              optimalUtilizationRate: '92',
              baseVariableBorrowRate: '5.75',
              variableRateSlope1: '0.75',
              variableRateSlope2: '50',
            },
            asset: '0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f',
            admin: '',
          },
        ],
      },
      cache: {blockNumber: 21118528},
    },
  },
};
