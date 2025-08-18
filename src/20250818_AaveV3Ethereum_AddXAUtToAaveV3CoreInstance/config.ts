import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Add XAUt to Aave v3 Core Instance',
    shortName: 'AddXAUtToAaveV3CoreInstance',
    date: '20250818',
    discussion: 'https://governance.aave.com/t/arfc-add-xaut-to-aave-v3-core-instance/22385',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'XAUt',
            decimals: 6,
            priceFeed: '0x214eD9Da11D2fbe465a6fc601a91E62EbEc1a0D6',
            ltv: '70',
            liqThreshold: '75',
            liqBonus: '6',
            debtCeiling: '3000000',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '5000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x68749665FF8D2d112Fa859AA293F07A622782F38',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 23170193},
    },
  },
};
