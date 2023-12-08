import {checkbox, select} from '@inquirer/prompts';
import {ENGINE_FLAGS, PoolIdentifier} from './types';
import {getEModes} from './common';

// TRANSLATIONS
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

interface PercentInputPrompt<T extends boolean> extends GenericPrompt<T> {
  toRay?: boolean;
}

export type PercentInputValues = typeof ENGINE_FLAGS.KEEP_CURRENT | string;

export type NumberInputValues = typeof ENGINE_FLAGS.KEEP_CURRENT | string;

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
      required: true,
    });
    return values.map((mode) => translateEModeToEModeLib(mode, pool));
  } else {
    console.log('No e-mode category active on the current pool');
  }
}
