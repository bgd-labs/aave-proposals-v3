import {getAddress, isHex} from 'viem';
import {Sentinel} from '../types';

/// Strip `<Lib>.` prefix and any trailing `_UNDERLYING` from a library accessor.
export function shortKey(accessor: string): string {
  return accessor
    .split('.')
    .pop()!
    .replace(/_UNDERLYING$/, '');
}

export function isLiteral(s: Sentinel): boolean {
  return s.kind === 'literal';
}

export function literalValue(s: Sentinel): string {
  return String((s as {kind: 'literal'; value: unknown}).value);
}

/// Render an address-or-lib-accessor as a Solidity expression. Hex literals are
/// EIP-55 checksummed (Solidity rejects non-checksummed hex). Library accessors
/// are returned verbatim.
export function solAddress(s: string): string {
  if (isHex(s) && s.length === 42) return getAddress(s);
  return s;
}
