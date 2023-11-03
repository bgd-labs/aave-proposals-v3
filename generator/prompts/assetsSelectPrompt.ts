import {checkbox} from '@inquirer/prompts';
import {GenericPoolPrompt} from './types';
import {getAssets} from '../common';
import {PoolIdentifier} from '../types';

/**
 * allows selecting multiple assets
 * TODO: enforce selection of at least one asset (next version of inquirer ships with required)
 * @param param0
 * @returns
 */
export async function assetsSelectPrompt({pool, message}: GenericPoolPrompt) {
  return await checkbox({
    message,
    choices: getAssets(pool).map((asset) => ({name: asset, value: asset})),
  });
}

export function translateAssetToAssetLibUnderlying(value: string, pool: PoolIdentifier) {
  return `${pool}Assets.${value}_UNDERLYING`;
}
