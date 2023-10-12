import {checkbox, input, select} from '@inquirer/prompts';
import {ENGINE_FLAGS, PoolIdentifier} from './types';
import {getAssets, getEModes} from './common';
import {getAddress, isAddress} from 'viem';

// VALIDATION
function isNumber(value: string) {
  return !isNaN(value as unknown as number);
}

function isNumberOrKeepCurrent(value: string) {
  if (value == ENGINE_FLAGS.KEEP_CURRENT || isNumber(value)) return true;
  return 'Must be number or KEEP_CURRENT';
}

function isAddressOrKeepCurrent(value: string) {
  if (value == ENGINE_FLAGS.KEEP_CURRENT_ADDRESS || isAddress(value)) return true;
  return 'Must be a calid address';
}

// TRANSFORMS
function transformNumberToPercent(value: string) {
  if (value && isNumber(value)) {
    return value.replace(/(?=(\d{2}$)+(?!\d))/g, '.') + ' %';
  }
  return value;
}

function transformNumberToHumanReadable(value: string) {
  if (value && isNumber(value)) {
    return value.replace(/(?=(\d{3}$)+(?!\d))/g, '.');
  }
  return value;
}

// TRANSLATIONS
function translateJsPercentToSol(value: string, bpsToRay?: boolean) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT) return `EngineFlags.KEEP_CURRENT`;
  if (bpsToRay) return `_bpsToRay(${value.replace(/(?=(\d{2}$))/g, '_')})`;
  return value.replace(/(?=(\d{2}$)+(?!\d))/g, '_');
}

function translateJsNumberToSol(value: string) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT) return `EngineFlags.KEEP_CURRENT`;
  return String(value).replace(/\B(?=(\d{3})+(?!\d))/g, '_');
}

function translateJsAddressToSol(value: string) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT_ADDRESS) return `EngineFlags.KEEP_CURRENT_ADDRESS`;
  return getAddress(value);
}

function translateEModeToEModeLib(value: string, pool: PoolIdentifier) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT) return `EngineFlags.KEEP_CURRENT`;
  return `${pool}EModes.${value}`;
}

function translateAssetToAssetLibUnderlying(value: string, pool: PoolIdentifier) {
  return `${pool}Assets.${value}_UNDERLYING`;
}

// PROMPTS
interface GenericPrompt {
  message: string;
  disableKeepCurrent?: boolean;
  transform?: (value: string) => string;
  defaultValue?: string;
}

export type BooleanSelectValues =
  | typeof ENGINE_FLAGS.KEEP_CURRENT
  | typeof ENGINE_FLAGS.ENABLED
  | typeof ENGINE_FLAGS.DISABLED;

export async function booleanSelect({message, disableKeepCurrent}: GenericPrompt) {
  return select({
    message,
    choices: [
      ...(disableKeepCurrent ? [] : [{value: ENGINE_FLAGS.KEEP_CURRENT}]),
      {value: ENGINE_FLAGS.ENABLED},
      {value: ENGINE_FLAGS.DISABLED},
    ],
  });
}

interface PercentInputPrompt extends GenericPrompt {
  toRay?: boolean;
}

export type PercentInputValues = typeof ENGINE_FLAGS.KEEP_CURRENT | string;

export async function percentInput({message, disableKeepCurrent, toRay}: PercentInputPrompt) {
  const value = await input({
    message,
    transformer: transformNumberToPercent,
    validate: disableKeepCurrent ? isNumber : isNumberOrKeepCurrent,
    ...(disableKeepCurrent ? {} : {default: ENGINE_FLAGS.KEEP_CURRENT}),
  });
  return translateJsPercentToSol(value, toRay);
}

export type NumberInputValues = typeof ENGINE_FLAGS.KEEP_CURRENT | string;

export async function numberInput({message, disableKeepCurrent}: GenericPrompt) {
  const value = await input({
    message,
    transformer: transformNumberToHumanReadable,
    validate: disableKeepCurrent ? isNumber : isNumberOrKeepCurrent,
    ...(disableKeepCurrent ? {} : {default: ENGINE_FLAGS.KEEP_CURRENT}),
  });
  return translateJsNumberToSol(value);
}

export async function addressInput({message, disableKeepCurrent}: GenericPrompt) {
  const value = await input({
    message,
    validate: disableKeepCurrent ? isAddress : isAddressOrKeepCurrent,
    ...(disableKeepCurrent ? {} : {default: ENGINE_FLAGS.KEEP_CURRENT_ADDRESS}),
  });
  return translateJsAddressToSol(value);
}

interface AssetsSelectPrompt extends Omit<GenericPrompt, 'disableKeepCurrent'> {
  pool: PoolIdentifier;
}

/**
 * allows selecting an asset
 * @param param0
 * @returns
 */
export async function assetsSelect({pool, message}: AssetsSelectPrompt) {
  const values = await checkbox({
    message,
    choices: getAssets(pool).map((asset) => ({name: asset, value: asset})),
  });
  return values.map((v) => translateAssetToAssetLibUnderlying(v, pool));
}

interface EModeSelectPrompt extends GenericPrompt {
  pool: PoolIdentifier;
}

export async function eModeSelect({message, disableKeepCurrent, pool}: EModeSelectPrompt) {
  const eModes = getEModes(pool as any);
  const eMode = await select({
    message,
    choices: [
      ...(disableKeepCurrent ? [] : [{value: ENGINE_FLAGS.KEEP_CURRENT}]),
      ...Object.keys(eModes).map((eMode) => ({value: eMode})),
    ],
  });
  return translateEModeToEModeLib(eMode, pool);
}

export async function eModesSelect({message, pool}: EModeSelectPrompt) {
  const eModes = getEModes(pool as any);
  const values = await checkbox({
    message,
    choices: [
      ...Object.keys(eModes)
        .filter((e) => e != 'NONE')
        .map((eMode) => ({value: eMode})),
    ],
  });
  return values.map((mode) => translateEModeToEModeLib(mode, pool));
}

export async function stringInput({message, defaultValue, disableKeepCurrent}: GenericPrompt) {
  return input({
    message,
    default: defaultValue,
    ...(disableKeepCurrent ? {} : {default: ENGINE_FLAGS.KEEP_CURRENT_STRING}),
  });
}
