import {getAddress, isHex} from 'viem';
import {Sentinel} from '../types';

/// Strip `<Lib>.` prefix and any trailing `_UNDERLYING` from a library accessor.
export function shortKey(accessor: string): string {
  return accessor
    .split('.')
    .pop()!
    .replace(/_UNDERLYING$/, '');
}

/// Derive a Solidity-identifier-safe key from a library accessor or address
/// literal: a `<Lib>.<KEY>` accessor yields `KEY` (trailing `_UNDERLYING`
/// stripped), a raw address literal yields `CUSTOM_<last 4 bytes>`.
export function accessorIdentifier(expr: string): string {
  if (isHex(expr) && expr.length === 42) {
    return `CUSTOM_${expr.replace(/^0x/, '').slice(-8).toUpperCase()}`;
  }
  return shortKey(expr);
}

/// Derive a Solidity-identifier-safe key from an `underlying` expression: a
/// `<Lib>.<KEY>_UNDERLYING` accessor yields `KEY`, a raw address literal yields
/// `CUSTOM_<last 4 bytes>`.
export function assetIdentifier(underlying: string): string {
  return accessorIdentifier(underlying);
}

export function isLiteral(s: Sentinel): boolean {
  return s.kind === 'literal';
}

/// Emits a Solidity assertion for an updated config field driven by a Sentinel:
/// - literal     -> assert the field equals the new value
/// - keepCurrent -> assert the field is unchanged (equals the `before` snapshot)
/// - ENABLED/DISABLED (bool fields only) -> assert the field is true/false
/// `cfgVar`/`beforeVar` are the post-execution and pre-execution struct locals.
export function assertSentinelField(
  field: string,
  s: Sentinel,
  kind: 'uint' | 'bool' | 'address',
  cfgVar = 'cfg',
  beforeVar = 'before',
): string {
  const cur = `${cfgVar}.${field}`;
  const prev = `${beforeVar}.${field}`;
  if (kind === 'bool') {
    if (s.kind === 'keepCurrent' && s.sentinel === 'ENABLED')
      return `assertTrue(${cur}, '${field} should be true');`;
    if (s.kind === 'keepCurrent' && s.sentinel === 'DISABLED')
      return `assertFalse(${cur}, '${field} should be false');`;
    if (s.kind === 'literal') return `assertEq(${cur}, ${literalValue(s)}, '${field} mismatch');`;
    return `assertEq(${cur}, ${prev}, '${field} unchanged');`;
  }
  if (kind === 'address') {
    if (s.kind === 'literal') return `assertEq(${cur}, ${literalValue(s)}, '${field} mismatch');`;
    return `assertEq(${cur}, ${prev}, '${field} unchanged');`;
  }
  if (s.kind === 'literal')
    return `assertEq(uint256(${cur}), uint256(${literalValue(s)}), '${field} mismatch');`;
  return `assertEq(uint256(${cur}), uint256(${prev}), '${field} unchanged');`;
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
