import {getAddress} from 'viem';
import {MarketIdentifierV4} from '../../types';

export type EntityKind = 'hub' | 'spoke' | 'tokenizationSpoke' | 'asset' | 'account';

export interface LabeledEntity {
  /// Solidity-identifier-safe constant name (e.g. `MAPLE_SPOKE`, `SYRUPUSDG`).
  label: string;
  /// Checksummed underlying address.
  address: string;
  kind: EntityKind;
}

/// Session registry of custom (non-address-book) entities the user has labeled, so a
/// hub/spoke/asset entered once is reused by its label across every later prompt and
/// emitted as a single named constant in the payload. Keyed by market, then by
/// lowercased address. Persisted into config.ts (`labels`) so a `-c` regeneration
/// re-hydrates it before building.
const registry = new Map<string, Map<string, LabeledEntity>>();

function marketMap(market: MarketIdentifierV4): Map<string, LabeledEntity> {
  let m = registry.get(market);
  if (!m) {
    m = new Map();
    registry.set(market, m);
  }
  return m;
}

/// Normalize a raw label into a Solidity-identifier-safe uppercase constant name.
export function toConstantName(label: string): string {
  const sanitized = label.replace(/[^A-Za-z0-9_]/g, '_').toUpperCase();
  return /^[0-9]/.test(sanitized) ? `_${sanitized}` : sanitized;
}

export function registerEntity(
  market: MarketIdentifierV4,
  address: string,
  label: string,
  kind: EntityKind,
): LabeledEntity {
  const entity: LabeledEntity = {
    label: toConstantName(label),
    address: getAddress(address),
    kind,
  };
  marketMap(market).set(address.toLowerCase(), entity);
  return entity;
}

export function lookupByAddress(
  market: MarketIdentifierV4,
  address: string,
): LabeledEntity | undefined {
  return marketMap(market).get(address.toLowerCase());
}

export function newEntities(market: MarketIdentifierV4): LabeledEntity[] {
  return [...marketMap(market).values()];
}

export function snapshot(market: MarketIdentifierV4): Record<string, LabeledEntity> {
  return Object.fromEntries(marketMap(market));
}

export function hydrate(
  market: MarketIdentifierV4,
  data: Record<string, LabeledEntity> | undefined,
): void {
  if (!data) return;
  const m = marketMap(market);
  for (const [addr, entity] of Object.entries(data)) m.set(addr.toLowerCase(), entity);
}

/// Test helper: clear all registered entities.
export function resetRegistry(): void {
  registry.clear();
}
