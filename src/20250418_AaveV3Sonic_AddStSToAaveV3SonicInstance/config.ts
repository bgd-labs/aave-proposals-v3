import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250418_AaveV3Sonic_AddStSToAaveV3SonicInstance/config.ts',
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Sonic'],
    title: 'Add stS to Aave v3 Sonic Instance',
    shortName: 'AddStSToAaveV3SonicInstance',
    date: '20250418',
    discussion: 'https://governance.aave.com/t/arfc-add-sts-to-aave-v3-sonic-instance/21445',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xb49491fa374865c309723a992da4d2b1f24e96f310b8842a01cf6215a48e5c6d',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Sonic: {
      configs: {
        EMODES_UPDATES: [
          {eModeCategory: 1, ltv: '87', liqThreshold: '90', liqBonus: '1', label: 'stS/wS'},
        ],
        EMODES_ASSETS: [
          {asset: 'stS', eModeCategory: '1', collateral: 'ENABLED', borrowable: 'DISABLED'},
          {asset: 'wS', eModeCategory: '1', collateral: 'DISABLED', borrowable: 'ENABLED'},
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'stS',
            decimals: 18,
            priceFeed: '0x5BA5D5213B47DFE020B1F8d6fB54Db3F74F9ea9a',
            ltv: '66',
            liqThreshold: '68',
            liqBonus: '10',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '30000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0xE5DA20F15420aD15DE0fa650600aFc998bbE3955',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 20871419},
    },
  },
};
