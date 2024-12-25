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
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x5c27aa8f1de66a3e56f535d60e4c1666a5617a36f8f81c09df2b0ea184a90290',
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
            liqProtocolFee: '0',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '20000000',
            borrowCap: '2500000',
            rateStrategyParams: {
              optimalUtilizationRate: '92',
              baseVariableBorrowRate: '10.50',
              variableRateSlope1: '3.00',
              variableRateSlope2: '50',
            },
            asset: '0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f',
            admin: '',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'GHO',
            eModeCategory: 'AaveV3EthereumLidoEModes.SUSDE_STABLECOINS',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'USDC',
            eModeCategory: 'AaveV3EthereumLidoEModes.LRT_STABLECOINS_MAIN',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'GHO',
            eModeCategory: 'AaveV3EthereumLidoEModes.LRT_STABLECOINS_MAIN',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
        ],
      },
      cache: {blockNumber: 21118528},
    },
  },
};
