import {Options} from '../../types';
import {EModeCategoryUpdate, Listing, PriceFeedUpdate} from '../types';

export const MOCK_OPTIONS: Options = {
  pools: ['AaveV3Ethereum'],
  title: 'test',
  shortName: 'Test',
  date: '20231023',
  author: 'test',
  discussion: 'test',
  snapshot: 'test',
};

export const assetListingConfig: Listing[] = [
  {
    assetSymbol: 'PSP',
    decimals: 18,
    priceFeed: '0x72AFAECF99C9d9C8215fF44C77B94B99C28741e8',
    ltv: '40_00',
    liqThreshold: '50_00',
    liqBonus: '5_00',
    debtCeiling: '100_000',
    liqProtocolFee: '20_00',
    enabledToBorrow: 'ENABLED',
    flashloanable: 'ENABLED',
    stableRateModeEnabled: 'DISABLED',
    borrowableInIsolation: 'DISABLED',
    withSiloedBorrowing: 'DISABLED',
    reserveFactor: '20_00',
    supplyCap: '10_000',
    borrowCap: '5_000',
    rateStrategyParams: {
      optimalUtilizationRate: '_bpsToRay(80_00)',
      baseVariableBorrowRate: '_bpsToRay(0)',
      variableRateSlope1: '_bpsToRay(10_00)',
      variableRateSlope2: '_bpsToRay(100_00)',
      stableRateSlope1: '_bpsToRay(10_00)',
      stableRateSlope2: '_bpsToRay(100_00)',
      baseStableRateOffset: '_bpsToRay(1_00)',
      stableRateExcessOffset: '_bpsToRay(0)',
      optimalStableToTotalDebtRatio: '_bpsToRay(10_00)',
    },
    eModeCategory: 'AaveV3EthereumEModes.NONE',
    asset: '0xcAfE001067cDEF266AfB7Eb5A286dCFD277f3dE5',
  },
];

export const priceFeedsUpdateConfig: PriceFeedUpdate[] = [
  {
    asset: 'DAI',
    priceFeed: '0xae7ab96520de3a18e5e111b5eaab095312d7fe84',
  },
];

export const emodeUpdates: EModeCategoryUpdate[] = [
  {
    eModeCategory: 2,
    ltv: '20_00',
    liqThreshold: '30_00',
    liqBonus: '5_00',
    priceSource: '0x0000000000000000000000000000000000000000',
    label: 'label',
  },
  {
    eModeCategory: 'AaveV3EthereumEModes.ETH_CORRELATED',
    ltv: 'EngineFlags.KEEP_CURRENT',
    liqThreshold: '50_00',
    liqBonus: 'EngineFlags.KEEP_CURRENT',
    priceSource: '',
    label: '',
  },
];
