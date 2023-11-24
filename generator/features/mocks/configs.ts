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
    ltv: '40',
    liqThreshold: '50',
    liqBonus: '5',
    debtCeiling: '100000',
    liqProtocolFee: '20',
    enabledToBorrow: 'ENABLED',
    flashloanable: 'ENABLED',
    stableRateModeEnabled: 'DISABLED',
    borrowableInIsolation: 'DISABLED',
    withSiloedBorrowing: 'DISABLED',
    reserveFactor: '20',
    supplyCap: '10000',
    borrowCap: '5000',
    rateStrategyParams: {
      optimalUtilizationRate: '80',
      baseVariableBorrowRate: '0',
      variableRateSlope1: '10',
      variableRateSlope2: '100',
      stableRateSlope1: '10',
      stableRateSlope2: '100',
      baseStableRateOffset: '1',
      stableRateExcessOffset: '0',
      optimalStableToTotalDebtRatio: '10',
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
