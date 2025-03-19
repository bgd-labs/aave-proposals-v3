import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Core Instance - Add ezETH and update rsETH eMode Parameters',
    shortName: 'CoreInstanceAddEzETHAndUpdateRsETHEModeParameters',
    date: '20250319',
    author: 'TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-core-instance-add-ezeth-and-update-rseth-emode-parameters/21505',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        CAPS_UPDATE: [{asset: 'rsETH', supplyCap: '550000', borrowCap: ''}],
        EMODES_UPDATES: [
          {eModeCategory: 7, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'ezETH_wETH'},
          {eModeCategory: 8, ltv: '93', liqThreshold: '95', liqBonus: '1', label: 'ezETH_wstETH'},
          {
            eModeCategory: 9,
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '1',
            label: 'rsETH_WETH',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'ezETH',
            eModeCategory: '7',
            collateral: 'KEEP_CURRENT',
            borrowable: 'ENABLED',
          },
          {
            asset: 'WETH',
            eModeCategory: '7',
            collateral: 'ENABLED',
            borrowable: 'KEEP_CURRENT',
          },
          {
            asset: 'ezETH',
            eModeCategory: '8',
            collateral: 'KEEP_CURRENT',
            borrowable: 'ENABLED',
          },
          {
            asset: 'wstETH',
            eModeCategory: '8',
            collateral: 'ENABLED',
            borrowable: 'KEEP_CURRENT',
          },
          {
            asset: 'rsETH',
            eModeCategory: '9',
            collateral: 'KEEP_CURRENT',
            borrowable: 'ENABLED',
          },
          {
            asset: 'WETH',
            eModeCategory: '9',
            collateral: 'ENABLED',
            borrowable: 'KEEP_CURRENT',
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'ezETH',
            decimals: 18,
            priceFeed: '0x68C9c7Bf43DBd0EBab102116bc7C3C9f7d9297Ee',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '150000',
            borrowCap: '0',
            rateStrategyParams: {
              optimalUtilizationRate: '40',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            asset: '0xbf5495Efe5DB9ce00f80364C8B423567e58d2110',
            admin: '',
          },
        ],
      },
      cache: {blockNumber: 22083013},
    },
  },
};
