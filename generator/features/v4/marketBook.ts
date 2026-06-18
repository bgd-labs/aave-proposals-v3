import * as addressBook from '@aave-dao/aave-address-book';
import {MarketIdentifierV4} from '../../types';

type V4Book = {
  ACCESS_MANAGER: string;
  HUB_CONFIGURATOR: string;
  SPOKE_CONFIGURATOR: string;
  CONFIG_ENGINE: string;
  HUBS: Record<string, string>;
  SPOKES: Record<string, string>;
  POSITION_MANAGERS: Record<string, string>;
  TOKENIZATION_SPOKES: Record<string, string>;
  ASSETS: Record<string, {UNDERLYING: string; decimals: number}>;
  SPOKE_PRICE_FEEDS: Record<string, string>;
  ALL_SPOKES_RAW: readonly string[];
};

export function getV4Book(market: MarketIdentifierV4): V4Book {
  return addressBook[market] as unknown as V4Book;
}

export function getMarketLibraryName(market: MarketIdentifierV4): string {
  return market;
}

export function hubLibAccessor(market: MarketIdentifierV4, hubKey: string): string {
  return `${market}Hubs.${hubKey}`;
}

export function spokeLibAccessor(market: MarketIdentifierV4, spokeKey: string): string {
  return `${market}Spokes.${spokeKey}`;
}

export function tokenizationSpokeLibAccessor(market: MarketIdentifierV4, spokeKey: string): string {
  return `${market}TokenizationSpokes.${spokeKey}`;
}

export function assetLibAccessor(market: MarketIdentifierV4, assetKey: string): string {
  return `${market}Assets.${assetKey}_UNDERLYING`;
}

export function positionManagerLibAccessor(market: MarketIdentifierV4, pmKey: string): string {
  return `${market}PositionManagers.${pmKey}`;
}

export function priceFeedLibAccessor(market: MarketIdentifierV4, feedKey: string): string {
  return `${market}SpokePriceFeeds.${feedKey}`;
}

export function hubKeys(market: MarketIdentifierV4): string[] {
  return Object.keys(getV4Book(market).HUBS);
}

export function spokeKeys(market: MarketIdentifierV4): string[] {
  return Object.keys(getV4Book(market).SPOKES).filter((k) => !k.endsWith('_ORACLE'));
}

export type SpokeChoice = {key: string; accessor: string};

/// All spoke types selectable for Hub-side spoke configuration, iterating the
/// address book's `ALL_SPOKES_RAW`: regular spokes (incl. TREASURY_SPOKE) and
/// tokenization spokes, excluding `*_ORACLE` entries.
export function rawSpokeKeys(market: MarketIdentifierV4): SpokeChoice[] {
  const book = getV4Book(market);
  const byAddress = new Map<string, SpokeChoice>();
  for (const [key, address] of Object.entries(book.SPOKES)) {
    byAddress.set(address.toLowerCase(), {key, accessor: spokeLibAccessor(market, key)});
  }
  for (const [key, address] of Object.entries(book.TOKENIZATION_SPOKES ?? {})) {
    byAddress.set(address.toLowerCase(), {
      key,
      accessor: tokenizationSpokeLibAccessor(market, key),
    });
  }
  return book.ALL_SPOKES_RAW.map((address) => byAddress.get(address.toLowerCase())).filter(
    (choice): choice is SpokeChoice => choice !== undefined,
  );
}

/// Returns the deployed TreasurySpoke for the market, or undefined if none.
export function treasurySpoke(
  market: MarketIdentifierV4,
): {key: string; accessor: string; address: string} | undefined {
  const address = getV4Book(market).SPOKES.TREASURY_SPOKE;
  if (!address) return undefined;
  return {key: 'TREASURY_SPOKE', accessor: spokeLibAccessor(market, 'TREASURY_SPOKE'), address};
}

export function assetKeys(market: MarketIdentifierV4): string[] {
  return Object.keys(getV4Book(market).ASSETS);
}

export function positionManagerKeys(market: MarketIdentifierV4): string[] {
  return Object.keys(getV4Book(market).POSITION_MANAGERS);
}
