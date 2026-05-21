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

export function assetKeys(market: MarketIdentifierV4): string[] {
  return Object.keys(getV4Book(market).ASSETS);
}

export function positionManagerKeys(market: MarketIdentifierV4): string[] {
  return Object.keys(getV4Book(market).POSITION_MANAGERS);
}
