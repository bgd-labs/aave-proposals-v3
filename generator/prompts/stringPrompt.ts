import {flagAsRequired} from '../common';
import {advancedInput} from './advancedInput';
import {GenericPrompt} from './types';

export async function stringPrompt<T extends boolean>(
  {message, defaultValue, required}: GenericPrompt<T>,
  opts?
) {
  return advancedInput(
    {
      message: flagAsRequired(message, required),
      default: defaultValue,
      validate: (v) => (required ? v.trim().length != 0 : true),
    },
    opts
  );
}

export function stringOrKeepCurrent(value: string) {
  if (!value) return `EngineFlags.KEEP_CURRENT_STRING`;
  return `"${value}"`;
}
