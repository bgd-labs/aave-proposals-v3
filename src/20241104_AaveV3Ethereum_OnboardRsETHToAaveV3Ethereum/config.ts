import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Onboard rsETH to Aave V3 Ethereum',
    shortName: 'OnboardRsETHToAaveV3Ethereum',
    date: '20241104',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-add-rseth-to-aave-v3-ethereum/17696',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xe83b67dfdddd469c298ce6133f4fdb84c9796c671c023b88617d5a25b5933c7f',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        CAPS_UPDATE: [
          {asset: 'wstETH', supplyCap: '', borrowCap: '60000'},
          {asset: 'ETHx', supplyCap: '', borrowCap: '5000'},
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 3,
            ltv: '92.5',
            liqThreshold: '94.5',
            liqBonus: '1',
            label: 'rsETH LST main',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'rsETH',
            decimals: 18,
            priceFeed: '0x47F52B2e43D0386cF161e001835b03Ad49889e3b',
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
            supplyCap: '19000',
            borrowCap: '1900',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            asset: '0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 21116205},
    },
  },
};
