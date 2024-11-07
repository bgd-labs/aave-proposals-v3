import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3BNB'],
    title: 'Onboard wstETH to Aave V3 on BNB Chain',
    shortName: 'OnboardWstETHToAaveV3OnBNBChain',
    date: '20241030',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-onboard-wsteth-to-aave-v3-on-bnb-chain/18501',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x752c396a86f1f9b60d3e43b7ed223d9d2f66014e03b6b3eb7ac59e8a169d1fe5',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3BNB: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 1, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'ETH-Correlated'},
        ],
        EMODES_ASSETS: [
          {asset: 'ETH', eModeCategory: '0', collateral: 'DISABLED', borrowable: 'ENABLED'},
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'wstETH',
            decimals: 18,
            priceFeed: '0xc1377B4cdF9116bf7b3d7F72A4f8A7Be8506cE80',
            ltv: '72',
            liqThreshold: '75',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '1900',
            borrowCap: '190',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            asset: '0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 43567833},
    },
  },
};
