import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Linea'],
    title: 'Add MetaMask (mUSD) to Aave V3 Ethereum/Linea',
    shortName: 'AddMetaMaskMUSDToAaveV3EthereumLinea',
    date: '20251120',
    author: 'TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-add-metamask-usd-musd-to-aave-v3-core-instance-on-ethereum-and-linea/23097',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x9abb72d91df849e8723ed6e8f20151310f42861a2c0d420f300324d855d787d9',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'mUSD',
            decimals: 6,
            priceFeed: '0xf22de319901C3b9BAEc7Fa14FdF013Ede40E7312',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '0',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '10000000',
            borrowCap: '8000000',
            rateStrategyParams: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '6.5',
              variableRateSlope2: '60',
            },
            asset: '0xacA92E438df0B2401fF60dA7E4337B687a2435DA',
            admin: '',
          },
        ],
      },
      cache: {blockNumber: 23840931},
    },
    AaveV3Linea: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'mUSD',
            decimals: 6,
            priceFeed: '0xB8454f3b48395103F23c88B699d4F6A81fD1DCff',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '0',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '70000000',
            borrowCap: '60000000',
            rateStrategyParams: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '6.5',
              variableRateSlope2: '60',
            },
            asset: '0xacA92E438df0B2401fF60dA7E4337B687a2435DA',
            admin: '',
          },
        ],
      },
      cache: {blockNumber: 25848289},
    },
  },
};
