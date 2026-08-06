import {checkbox} from '@inquirer/prompts';
import {GenericMarketPrompt} from './types';
import {getAssets} from '../common';
import {FEATURE, MarketConfig, MarketIdentifier} from '../types';

interface AssetsSelectPrompt extends GenericMarketPrompt {
  additionalAssets?: string[];
}

/**
 * allows selecting multiple assets
 * TODO: enforce selection of at least one asset (next version of inquirer ships with required)
 */
export async function assetsSelectPrompt({
  market,
  message,
  additionalAssets = [],
}: AssetsSelectPrompt) {
  const choices = [
    ...getAssets(market).map((asset) => ({name: asset, value: asset})),
    ...additionalAssets.map((asset) => ({name: `${asset} (new listing)`, value: asset})),
  ];
  return await checkbox({
    message,
    choices,
  });
}

export function translateAssetToAssetLibUnderlying(
  value: string,
  market: MarketIdentifier,
  newListings: ReadonlySet<string> = new Set(),
) {
  if (newListings.has(value)) return value;
  return `${market}Assets.${value}_UNDERLYING`;
}

export function getNewListingSymbols(configs: MarketConfig['configs']): string[] {
  const symbols: string[] = [];
  const standard = configs[FEATURE.ASSET_LISTING];
  if (standard) symbols.push(...standard.map((l) => l.assetSymbol));
  const custom = configs[FEATURE.ASSET_LISTING_CUSTOM];
  if (custom) symbols.push(...custom.map((l) => l.base.assetSymbol));
  return symbols;
}
