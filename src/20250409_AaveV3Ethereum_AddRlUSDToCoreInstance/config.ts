import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Add rlUSD to Core Instance',
    shortName: 'AddRlUSDToCoreInstance',
    date: '20250409',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-add-rlusd-to-core-instance/20214',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x539ad30f3d3d531702bb7619fc0a9a44dc2da6a8e022eff7ffdc678032e0a8b9',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'RLUSD',
            decimals: 18,
            priceFeed: '0x26C46B7aD0012cA71F2298ada567dC9Af14E7f2A',
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
            supplyCap: '50000000',
            borrowCap: '40000000',
            rateStrategyParams: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '6.5',
              variableRateSlope2: '50',
            },
            asset: '0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 22231967},
    },
  },
};
