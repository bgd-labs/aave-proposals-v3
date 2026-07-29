import * as addressBook from '@aave-dao/aave-address-book';
import {isAddress} from 'viem';
import {MarketIdentifierV4} from '../../types';
import {getMarketChain} from '../../common';

export interface KnownAddress {
  /// Solidity accessor expression (e.g. `AaveV4Ethereum.TREASURY_SPOKE`).
  expr: string;
  /// Short label (the address-book key, e.g. `TREASURY_SPOKE`).
  label: string;
}

/// Map of address-book map fields to their generated Solidity library suffix.
const MAP_LIBS: Record<string, string> = {
  HUBS: 'Hubs',
  SPOKES: 'Spokes',
  TOKENIZATION_SPOKES: 'TokenizationSpokes',
  POSITION_MANAGERS: 'PositionManagers',
  IR_STRATEGIES: 'IRStrategies',
  SPOKE_PRICE_FEEDS: 'SpokePriceFeeds',
};

/// Top-level scalar address fields, exposed directly on the market library.
const SCALARS = [
  'ACCESS_MANAGER',
  'CONFIG_ENGINE',
  'HUB_CONFIGURATOR',
  'SPOKE_CONFIGURATOR',
  'TREASURY_SPOKE',
];

const cache = new Map<string, Map<string, KnownAddress>>();

function assetConstantName(symbol: string): string {
  return symbol.replace(/[^A-Za-z0-9]/g, '');
}

function buildReverseMap(market: MarketIdentifierV4): Map<string, KnownAddress> {
  const book = (addressBook as Record<string, any>)[market];
  const result = new Map<string, KnownAddress>();
  const add = (address: unknown, expr: string, label: string) => {
    if (typeof address === 'string' && isAddress(address)) {
      result.set(address.toLowerCase(), {expr, label});
    }
  };

  for (const [field, suffix] of Object.entries(MAP_LIBS)) {
    for (const [key, address] of Object.entries(book[field] ?? {})) {
      add(address, `${market}${suffix}.${key}`, key);
    }
  }
  for (const [symbol, data] of Object.entries<any>(book.ASSETS ?? {})) {
    const name = assetConstantName(symbol);
    add(data?.UNDERLYING, `${market}Assets.${name}_UNDERLYING`, symbol);
  }
  // Scalars last so a top-level entry (e.g. TREASURY_SPOKE) overrides its map duplicate.
  for (const key of SCALARS) {
    add(book[key], `${market}.${key}`, key);
  }

  const chain = getMarketChain(market);
  const gov = (addressBook as Record<string, any>)[`GovernanceV3${chain}`];
  if (gov) {
    for (const [key, address] of Object.entries(gov)) {
      add(address, `GovernanceV3${chain}.${key}`, key);
    }
  }
  return result;
}

/// Resolve a raw address to its known address-book accessor for the given market
/// (including the chain governance book), or undefined if unknown.
export function resolveKnownAddress(
  market: MarketIdentifierV4,
  address: string,
): KnownAddress | undefined {
  if (!cache.has(market)) cache.set(market, buildReverseMap(market));
  return cache.get(market)!.get(address.toLowerCase());
}
