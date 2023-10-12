import {Hex} from 'viem';
import {BooleanSelectValues, NumberInputValues, PercentInputValues} from '../prompts';

export interface AssetSelector {
  asset: string;
}

export interface TokenImplementations {
  aToken: Hex;
  vToken: Hex;
  sToken: Hex;
}

export interface CapsUpdatePartial {
  supplyCap: NumberInputValues;
  borrowCap: NumberInputValues;
}

export interface CapsUpdate extends CapsUpdatePartial, AssetSelector {}

export interface BorrowUpdatePartial {
  enabledToBorrow: BooleanSelectValues;
  flashloanable: BooleanSelectValues;
  stableRateModeEnabled: BooleanSelectValues;
  borrowableInIsolation: BooleanSelectValues;
  withSiloedBorrowing: BooleanSelectValues;
  reserveFactor: PercentInputValues;
}

export interface BorrowUpdate extends BorrowUpdatePartial, AssetSelector {}

export interface CollateralUpdatePartial {
  ltv: PercentInputValues;
  liqThreshold: PercentInputValues;
  liqBonus: PercentInputValues;
  debtCeiling: NumberInputValues;
  liqProtocolFee: PercentInputValues;
  eModeCategory: string;
}

export interface CollateralUpdate extends CollateralUpdatePartial, AssetSelector {}

export interface PriceFeedUpdatePartial {
  priceFeed: Hex;
}

export interface PriceFeedUpdate extends PriceFeedUpdatePartial, AssetSelector {}

export interface AssetEModeUpdatePartial {
  eModeCategory: string;
}

export interface AssetEModeUpdate extends AssetEModeUpdatePartial, AssetSelector {}

export interface EModeCategoryUpdate {
  eModeCategory: string;
  ltv: NumberInputValues;
  liqThreshold: NumberInputValues;
  liqBonus: NumberInputValues;
  priceSource: Hex;
  label: string;
}

export interface RateStrategyParams {
  optimalUtilizationRate: string;
  baseVariableBorrowRate: string;
  variableRateSlope1: string;
  variableRateSlope2: string;
  stableRateSlope1: string;
  stableRateSlope2: string;
  baseStableRateOffset?: string;
  stableRateExcessOffset?: string;
  optimalStableToTotalDebtRatio?: string;
}

export interface RateStrategyUpdate extends AssetSelector {
  params: RateStrategyParams;
}

export interface Listing
  extends CollateralUpdatePartial,
    BorrowUpdatePartial,
    CapsUpdatePartial,
    PriceFeedUpdatePartial {
  asset: Hex;
  assetSymbol: string;
  rateStrategyParams: RateStrategyParams;
}

export interface ListingWithCustomImpl {
  base: Listing;
  implementations: TokenImplementations;
}
