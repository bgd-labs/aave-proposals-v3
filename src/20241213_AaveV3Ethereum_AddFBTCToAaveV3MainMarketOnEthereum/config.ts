import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20241213_AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum/config.ts',
    update: true,
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Add FBTC to Aave v3 Main Market on Ethereum',
    shortName: 'AddFBTCToAaveV3MainMarketOnEthereum',
    date: '20241213',
    discussion:
      'https://governance.aave.com/t/arfc-add-fbtc-to-aave-v3-main-market-on-ethereum/19937',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x2ca8db490e132cebfec25ddbf460b89abd710456c5177bca784abaae9d6009d9',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 8, ltv: '84', liqThreshold: '86', liqBonus: '3', label: 'FBTC/WBTC'},
        ],
        EMODES_ASSETS: [
          {asset: 'FBTC', eModeCategory: '8', collateral: 'ENABLED', borrowable: 'DISABLED'},
          {asset: 'WBTC', eModeCategory: '8', collateral: 'DISABLED', borrowable: 'ENABLED'},
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'FBTC',
            decimals: 8,
            priceFeed: '0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c',
            ltv: '73',
            liqThreshold: '78',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '50',
            supplyCap: '200',
            borrowCap: '100',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '4',
              variableRateSlope2: '300',
            },
            asset: '0xC96dE26018A54D51c097160568752c4E3BD6C364',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 22366110},
    },
  },
};
