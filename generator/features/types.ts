import {Hex} from 'viem';
import {NumberInputValues, PercentInputValues} from '../prompts';
import {BooleanSelectValues} from '../prompts/boolPrompt';

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
  // library accessor or new id
  eModeCategory: string | number;
  ltv: NumberInputValues;
  liqThreshold: NumberInputValues;
  liqBonus: NumberInputValues;
  priceSource?: Hex | '';
  label: string;
}

export interface RateStrategyParams {
  optimalUtilizationRate: string;
  baseVariableBorrowRate: string;
  variableRateSlope1: string;
  variableRateSlope2: string;
  stableRateSlope1?: string;
  stableRateSlope2?: string;
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
  eModeCategory: string;
  decimals: number;
}

export interface ListingWithCustomImpl {
  base: Listing;
  implementations: TokenImplementations;
}

export interface TokenStream {
  asset: Hex;
  receiver: Hex;
  duration: string;
  amount: string;
}

export interface FreezeUpdate extends AssetSelector {
  shouldBeFrozen: boolean;
}
