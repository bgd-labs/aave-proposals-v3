import {getAddress, isHex} from 'viem';
import {Sentinel} from '../types';

/// Strip `<Lib>.` prefix and any trailing `_UNDERLYING` from a library accessor.
export function shortKey(accessor: string): string {
  return accessor
    .split('.')
    .pop()!
    .replace(/_UNDERLYING$/, '');
}

/// Derive a Solidity-identifier-safe key from an `underlying` expression: a
/// `<Lib>.<KEY>_UNDERLYING` accessor yields `KEY`, a raw address literal yields
/// `CUSTOM_<last 4 bytes>`.
export function assetIdentifier(underlying: string): string {
  if (isHex(underlying) && underlying.length === 42) {
    return `CUSTOM_${underlying.replace(/^0x/, '').slice(-8).toUpperCase()}`;
  }
  return shortKey(underlying);
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
export function checksumAddress(s: string): string {
  if (isHex(s) && s.length === 42) return getAddress(s);
  return s;
}
