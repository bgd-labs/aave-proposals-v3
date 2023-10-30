import {checkbox, input, select} from '@inquirer/prompts';
import {ENGINE_FLAGS, PoolIdentifier} from './types';
import {getAssets, getEModes} from './common';
import {Hex, getAddress, isAddress} from 'viem';

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
  return 'Must be a valid address';
}

// TRANSFORMS
function transformNumberToPercent(value: string) {
  if (value && isNumber(value)) {
    if (Number(value) <= 9) value = value.padStart(2, '0');
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

function translateJsBoolToSol(value: string) {
  switch (value) {
    case ENGINE_FLAGS.ENABLED:
      return `EngineFlags.ENABLED`;
    case ENGINE_FLAGS.DISABLED:
      return `EngineFlags.DISABLED`;
    case ENGINE_FLAGS.KEEP_CURRENT:
      return `EngineFlags.KEEP_CURRENT`;
    default:
      return value;
  }
}

function translateJsStringToSol(value: string) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT_STRING) return `EngineFlags.KEEP_CURRENT_STRING`;
  return value;
}

function translateEModeToEModeLib(value: string, pool: PoolIdentifier) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT) return `EngineFlags.KEEP_CURRENT`;
  return `${pool}EModes.${value}`;
}

function translateAssetToAssetLibUnderlying(value: string, pool: PoolIdentifier) {
  return `${pool}Assets.${value}_UNDERLYING`;
}

// PROMPTS
interface GenericPrompt<T extends boolean = boolean> {
  message: string;
  disableKeepCurrent?: T;
  transform?: (value: string) => string;
  defaultValue?: string;
}

export type BooleanSelectValues =
  | typeof ENGINE_FLAGS.KEEP_CURRENT
  | typeof ENGINE_FLAGS.ENABLED
  | typeof ENGINE_FLAGS.DISABLED;

export async function booleanSelect<T extends boolean>({
  message,
  disableKeepCurrent,
  defaultValue,
}: GenericPrompt<T>): Promise<
  T extends true ? Exclude<BooleanSelectValues, 'KEEP_CURRENT'> : BooleanSelectValues
> {
  const choices = [
    ...(disableKeepCurrent ? [] : [{value: ENGINE_FLAGS.KEEP_CURRENT}]),
    {value: ENGINE_FLAGS.ENABLED},
    {value: ENGINE_FLAGS.DISABLED},
  ];
  const value = await select({
    message,
    choices: choices,
  });
  return translateJsBoolToSol(value) as T extends true
    ? Exclude<BooleanSelectValues, 'KEEP_CURRENT'>
    : BooleanSelectValues;
}

interface PercentInputPrompt<T extends boolean> extends GenericPrompt<T> {
  toRay?: boolean;
}

export type PercentInputValues = typeof ENGINE_FLAGS.KEEP_CURRENT | string;

export async function percentInput<T extends boolean>({
  message,
  disableKeepCurrent,
  toRay,
}: PercentInputPrompt<T>): Promise<
  T extends true ? PercentInputValues : Exclude<PercentInputValues, 'KEEP_CURRENT'>
> {
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

export type AddressInputValues = Hex | typeof ENGINE_FLAGS.KEEP_CURRENT_ADDRESS;

export async function addressInput<T extends boolean>({
  message,
  disableKeepCurrent,
}: GenericPrompt<T>): Promise<T extends true ? Hex : AddressInputValues> {
  const value = await input({
    message,
    validate: disableKeepCurrent ? isAddress : isAddressOrKeepCurrent,
    ...(disableKeepCurrent ? {} : {default: ENGINE_FLAGS.KEEP_CURRENT_ADDRESS}),
  });
  return translateJsAddressToSol(value) as T extends true ? Hex : AddressInputValues;
}

interface AssetsSelectPrompt extends Exclude<GenericPrompt, 'disableKeepCurrent'> {
  pool: PoolIdentifier;
}

/**
 * allows selecting multiple assets
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

interface EModeSelectPrompt<T extends boolean> extends GenericPrompt<T> {
  pool: PoolIdentifier;
}

export async function eModeSelect<T extends boolean>({
  message,
  disableKeepCurrent,
  pool,
}: EModeSelectPrompt<T>) {
  const eModes = getEModes(pool as any);
  if (Object.keys(eModes).length != 0) {
    const eMode = await select({
      message,
      choices: [
        ...(disableKeepCurrent ? [] : [{value: ENGINE_FLAGS.KEEP_CURRENT}]),
        ...Object.keys(eModes).map((eMode) => ({value: eMode})),
      ],
    });
    return translateEModeToEModeLib(eMode, pool);
  } else {
    console.log('No e-mode category active on the current pool');
    return '0';
  }
}

export async function eModesSelect<T extends boolean>({message, pool}: EModeSelectPrompt<T>) {
  const eModes = getEModes(pool as any);
  if (Object.keys(eModes).length != 0) {
    const values = await checkbox({
      message,
      choices: [
        ...Object.keys(eModes)
          .filter((e) => e != 'NONE')
          .map((eMode) => ({value: eMode})),
      ],
    });
    return values.map((mode) => translateEModeToEModeLib(mode, pool));
  } else {
    console.log('No e-mode category active on the current pool');
  }
}

export async function stringInput<T extends boolean>({
  message,
  defaultValue,
  disableKeepCurrent,
}: GenericPrompt<T>) {
  const value = await input({
    message,
    default: defaultValue,
    ...(disableKeepCurrent ? {} : {default: ENGINE_FLAGS.KEEP_CURRENT_STRING}),
  });
  return translateJsStringToSol(value);
}
