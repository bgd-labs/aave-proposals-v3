import {Hex, getAddress, isAddress} from 'viem';
import {GenericPrompt} from './types';
import {advancedInput} from './advancedInput';
import {flagAsRequired} from '../common';

export async function addressPrompt<T extends boolean>(
  {message, required}: GenericPrompt<T>,
  opts?
): Promise<T extends true ? Hex : Hex | ''> {
  const value = await advancedInput(
    {
      message: flagAsRequired(message, required),
      validate: (v) => (required ? isAddress(v) : isAddress(v) || v === ''),
      pattern: /^(0|0x|0x[A-Fa-f0-9]{0,40})?$/,
    },
    opts
  );
  return value as Hex;
}

export function translateJsAddressToSol(value?: string) {
  if (!value) return `EngineFlags.KEEP_CURRENT_ADDRESS`;
  return getAddress(value);
}
