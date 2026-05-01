import {checkbox} from '@inquirer/prompts';
import {GenericPoolPrompt} from './types';
import {getAssets} from '../common';
import {FEATURE, PoolConfig, PoolIdentifier} from '../types';

interface AssetsSelectPrompt extends GenericPoolPrompt {
  additionalAssets?: string[];
}

/**
 * allows selecting multiple assets
 * TODO: enforce selection of at least one asset (next version of inquirer ships with required)
 */
export async function assetsSelectPrompt({
  pool,
  message,
  additionalAssets = [],
}: AssetsSelectPrompt) {
  const choices = [
    ...getAssets(pool).map((asset) => ({name: asset, value: asset})),
    ...additionalAssets.map((asset) => ({name: `${asset} (new listing)`, value: asset})),
  ];
  return await checkbox({
    message,
    choices,
  });
}

export function translateAssetToAssetLibUnderlying(
  value: string,
  pool: PoolIdentifier,
  newListings: ReadonlySet<string> = new Set(),
) {
  if (newListings.has(value)) return value;
  return `${pool}Assets.${value}_UNDERLYING`;
}

export function getNewListingSymbols(configs: PoolConfig['configs']): string[] {
  const symbols: string[] = [];
  const standard = configs[FEATURE.ASSET_LISTING];
  if (standard) symbols.push(...standard.map((l) => l.assetSymbol));
  const custom = configs[FEATURE.ASSET_LISTING_CUSTOM];
  if (custom) symbols.push(...custom.map((l) => l.base.assetSymbol));
  return symbols;
}
