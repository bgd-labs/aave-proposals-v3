import {input} from '@inquirer/prompts';
import {getAddress} from 'viem';
import {MarketIdentifierV4} from '../../types';
import {resolveKnownAddress} from './resolveKnownAddress';
import {lookupByAddress, registerEntity, EntityKind} from './labelRegistry';
import {readErc20Symbol} from './onchain';

export interface ResolvedEntity {
  /// Solidity expression to reference this entity in codegen: an address-book
  /// accessor when known, otherwise a named-constant identifier (its label).
  expr: string;
  /// Short label / constant name.
  label: string;
  /// True when the address resolved to an existing address-book entry.
  isKnown: boolean;
}

/// Resolve a user-entered address into a codegen expression:
/// 1. address-book entry (this market or its chain governance) -> its accessor;
/// 2. already labeled this session -> its constant name;
/// 3. otherwise -> a named constant, using the on-chain symbol for assets or a
///    prompted label for other kinds, registered so it is reused and emitted once.
export async function resolveEntity(
  market: MarketIdentifierV4,
  address: string,
  kind: EntityKind,
  opts: {defaultLabel?: string; labelMessage?: string} = {},
): Promise<ResolvedEntity> {
  const known = resolveKnownAddress(market, address);
  if (known) {
    console.log(`  ↳ ${address} is ${known.expr} (address book)`);
    return {expr: known.expr, label: known.label, isKnown: true};
  }

  const existing = lookupByAddress(market, address);
  if (existing) return {expr: existing.label, label: existing.label, isKnown: false};

  let label: string;
  if (kind === 'asset') {
    label = opts.defaultLabel ?? (await readErc20Symbol(market, getAddress(address)));
  } else {
    label = await input({
      message: opts.labelMessage ?? `Label for this ${kind} (used as the payload constant name)`,
      default: opts.defaultLabel,
      validate: (v) => v.trim().length > 0 || 'Label is required',
    });
  }
  const entity = registerEntity(market, address, label, kind);
  return {expr: entity.label, label: entity.label, isKnown: false};
}
