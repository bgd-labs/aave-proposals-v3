import {checkbox, input, select} from '@inquirer/prompts';
import {ENGINE_FLAGS, PoolIdentifier} from './types';
import {getAssets, getEModes} from './common';
import {advancedInput} from './prompts/advancedInput';

// VALIDATION
function isNumber(value: string) {
  return !isNaN(value as unknown as number);
}

function isNumberOrKeepCurrent(value: string) {
  if (value == ENGINE_FLAGS.KEEP_CURRENT || isNumber(value)) return true;
  return 'Must be number or KEEP_CURRENT';
}

// TRANSFORMS
export function transformNumberToPercent(value: string) {
  if (value && isNumber(value)) {
    return (
      new Intl.NumberFormat('en-us', {
        maximumFractionDigits: 2,
      }).format(value as unknown as number) + ' %'
    );
  }
  return value;
}

export function transformNumberToHumanReadable(value: string) {
  if (value && isNumber(value)) {
    return new Intl.NumberFormat('en-us').format(BigInt(value));
  }
  return value;
}

// TRANSLATIONS
export function translateJsPercentToSol(value: string, bpsToRay?: boolean) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT) return `EngineFlags.KEEP_CURRENT`;
  const formattedValue = new Intl.NumberFormat('en-us', {
    maximumFractionDigits: 2,
    minimumFractionDigits: 2,
  }).format(value as unknown as number);
  const _value = (
    Number(value) >= 1 ? formattedValue : formattedValue.replace(/^0\.0*(?=[0-9])/, '')
  ).replace(/[\.,]/g, '_');
  if (bpsToRay) return `_bpsToRay(${_value})`;
  return _value;
}

export function translateJsNumberToSol(value: string) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT) return `EngineFlags.KEEP_CURRENT`;
  return String(value).replace(/\B(?=(\d{3})+(?!\d))/g, '_');
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

function translateEModeToEModeLib(value: string, pool: PoolIdentifier) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT) return `EngineFlags.KEEP_CURRENT`;
  return `${pool}EModes.${value}`;
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
    default: defaultValue,
  });
  return translateJsBoolToSol(value) as T extends true
    ? Exclude<BooleanSelectValues, 'KEEP_CURRENT'>
    : BooleanSelectValues;
}

interface PercentInputPrompt<T extends boolean> extends GenericPrompt<T> {
  toRay?: boolean;
}

export type PercentInputValues = typeof ENGINE_FLAGS.KEEP_CURRENT | string;

export async function percentInput<T extends boolean>(
  {message, disableKeepCurrent, toRay}: PercentInputPrompt<T>,
  opts?
): Promise<T extends true ? PercentInputValues : Exclude<PercentInputValues, 'KEEP_CURRENT'>> {
  const value = await advancedInput(
    {
      message,
      transformer: transformNumberToPercent,
      validate: disableKeepCurrent ? isNumber : isNumberOrKeepCurrent,
      ...(disableKeepCurrent ? {} : {default: ENGINE_FLAGS.KEEP_CURRENT}),
      pattern: /^[0-9]*\.?[0-9]*$/,
      patternError: 'Only decimal numbers are allowed (e.g. 1.1)',
    },
    opts
  );
  return translateJsPercentToSol(value, toRay);
}

export type NumberInputValues = typeof ENGINE_FLAGS.KEEP_CURRENT | string;

export async function numberInput({message, disableKeepCurrent}: GenericPrompt, opts?) {
  const value = await advancedInput(
    {
      message,
      transformer: transformNumberToHumanReadable,
      validate: disableKeepCurrent ? isNumber : isNumberOrKeepCurrent,
      ...(disableKeepCurrent ? {} : {default: ENGINE_FLAGS.KEEP_CURRENT}),
      pattern: /^[0-9]*$/,
      patternError: 'Only full numbers are allowed',
    },
    opts
  );
  return translateJsNumberToSol(value);
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
