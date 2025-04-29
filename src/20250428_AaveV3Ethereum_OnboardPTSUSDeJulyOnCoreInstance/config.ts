import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Onboard PT sUSDe July on Core Instance',
    shortName: 'OnboardPTSUSDeJulyOnCoreInstance',
    date: '20250428',
    author: 'BGD Labs (@bgdlabs)',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-susde-july-expiry-pt-tokens-on-aave-v3-core-instance/21878',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xc039953e4f18804bb017876d27621da1ab3e4de53acd3b32d0f1fe94d4bbb6a0',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 7,
            ltv: '87.4',
            liqThreshold: '89.4',
            liqBonus: '4.6',
            label: 'PT-sUSDe Stablecoins Jul 2025',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'PT_sUSDE_31JUL2025',
            decimals: 18,
            priceFeed: '0x759B9B72700A129CD7AD8e53F9c99cb48Fd57105',
            ltv: '0.05',
            liqThreshold: '0.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '85000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            asset: '0x3b3fB9C57858EF816833dC91565EFcd85D96f634',
            admin: '',
          },
        ],
      },
      cache: {blockNumber: 22365369},
    },
  },
};
