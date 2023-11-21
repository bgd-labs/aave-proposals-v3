import {select} from '@inquirer/prompts';
import {ENGINE_FLAGS} from '../types';
import {GenericPrompt} from './types';

export type BooleanSelectValues =
  | typeof ENGINE_FLAGS.KEEP_CURRENT
  | typeof ENGINE_FLAGS.ENABLED
  | typeof ENGINE_FLAGS.DISABLED;

export async function boolPrompt<T extends boolean>({
  message,
  required,
  defaultValue,
}: GenericPrompt<T> & {
  defaultValue?: T extends true
    ? Exclude<BooleanSelectValues, 'KEEP_CURRENT'>
    : BooleanSelectValues;
}): Promise<T extends true ? Exclude<BooleanSelectValues, 'KEEP_CURRENT'> : BooleanSelectValues> {
  const choices = [
    ...(required ? [] : [{value: ENGINE_FLAGS.KEEP_CURRENT}]),
    {value: ENGINE_FLAGS.ENABLED},
    {value: ENGINE_FLAGS.DISABLED},
  ];
  return select<
    T extends true ? Exclude<BooleanSelectValues, 'KEEP_CURRENT'> : BooleanSelectValues
  >({
    message,
    choices: choices as any,
    default: defaultValue,
  });
}

export function translateJsBoolToSol(value: string) {
  switch (value) {
    case ENGINE_FLAGS.ENABLED:
      return `EngineFlags.ENABLED`;
    case ENGINE_FLAGS.DISABLED:
      return `EngineFlags.DISABLED`;
    case ENGINE_FLAGS.KEEP_CURRENT:
      return `EngineFlags.KEEP_CURRENT`;
    default:
      throw new Error('unknown boolean select value');
  }
}
