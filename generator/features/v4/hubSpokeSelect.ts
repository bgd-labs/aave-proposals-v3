import {select, checkbox, confirm} from '@inquirer/prompts';
import {Hex, getAddress} from 'viem';
import {MarketIdentifierV4} from '../../types';
import {addressPrompt} from '../../prompts/addressPrompt';
import {
  getV4Book,
  hubKeys,
  spokeKeys,
  rawSpokeKeys,
  hubLibAccessor,
  spokeLibAccessor,
} from './marketBook';
import {resolveEntity} from './entityInput';

const CUSTOM = '__custom__';

export type SelectedHub = {
  /// Display label / identifier: a book key, or the assigned label for a custom hub.
  key: string;
  /// Underlying address, used for on-chain reads.
  address: Hex;
  /// Solidity expression for codegen: a `<Market>Hubs.<KEY>` accessor for book
  /// hubs, or a named-constant identifier for a custom hub.
  expr: string;
  /// True for a custom hub not present in the address book (a fresh deploy).
  isNew: boolean;
};

export type SelectedSpoke = {
  key: string;
  address: Hex;
  expr: string;
  isNew: boolean;
};

async function customHub(m: MarketIdentifierV4): Promise<SelectedHub> {
  const address = await addressPrompt({message: 'Hub address', required: true});
  const {expr, label, isKnown} = await resolveEntity(m, address, 'hub');
  return {key: label, address: getAddress(address), expr, isNew: !isKnown};
}

async function customSpoke(m: MarketIdentifierV4): Promise<SelectedSpoke> {
  const address = await addressPrompt({message: 'Spoke address', required: true});
  const {expr, label, isKnown} = await resolveEntity(m, address, 'spoke');
  return {key: label, address: getAddress(address), expr, isNew: !isKnown};
}

function bookSpokes(m: MarketIdentifierV4, raw: boolean): SelectedSpoke[] {
  const book = getV4Book(m);
  if (raw) {
    return rawSpokeKeys(m).map((s) => ({
      key: s.key,
      address: (book.SPOKES[s.key] ?? book.TOKENIZATION_SPOKES?.[s.key] ?? '') as Hex,
      expr: s.accessor,
      isNew: false,
    }));
  }
  return spokeKeys(m).map((k) => ({
    key: k,
    address: book.SPOKES[k] as Hex,
    expr: spokeLibAccessor(m, k),
    isNew: false,
  }));
}

/// Prompt for a single hub, allowing either a known address-book hub or a custom
/// hub address not present in the book.
export async function selectHub(m: MarketIdentifierV4): Promise<SelectedHub> {
  const book = getV4Book(m);
  const choice = await select({
    message: 'Select hub',
    choices: [
      ...hubKeys(m).map((k) => ({name: k, value: k})),
      {name: 'Custom address…', value: CUSTOM},
    ],
  });
  if (choice === CUSTOM) return customHub(m);
  return {
    key: choice,
    address: book.HUBS[choice] as Hex,
    expr: hubLibAccessor(m, choice),
    isNew: false,
  };
}

/// Prompt for a single spoke, allowing either a known address-book spoke or a
/// custom spoke address not present in the book. Pass `raw` to iterate the full
/// `ALL_SPOKES_RAW` set (incl. tokenization/treasury spokes).
export async function selectSpoke(
  m: MarketIdentifierV4,
  opts: {raw?: boolean} = {},
): Promise<SelectedSpoke> {
  const spokes = bookSpokes(m, opts.raw ?? false);
  const choice = await select({
    message: 'Select spoke',
    choices: [
      ...spokes.map((s) => ({name: s.key, value: s.key})),
      {name: 'Custom address…', value: CUSTOM},
    ],
  });
  if (choice === CUSTOM) return customSpoke(m);
  return spokes.find((s) => s.key === choice)!;
}

/// Prompt for multiple spokes via a checkbox, then optionally append custom spoke
/// addresses not present in the book. `only` restricts the book choices to the
/// given keys (used for on-chain-filtered candidate lists).
export async function selectSpokes(
  m: MarketIdentifierV4,
  opts: {message?: string; raw?: boolean; only?: string[]} = {},
): Promise<SelectedSpoke[]> {
  let spokes = bookSpokes(m, opts.raw ?? false);
  if (opts.only) {
    const allow = new Set(opts.only);
    spokes = spokes.filter((s) => allow.has(s.key));
  }
  const chosen = await checkbox({
    message: opts.message ?? 'Select spokes',
    choices: spokes.map((s) => ({name: s.key, value: s.key})),
  });
  const result = chosen.map((key) => spokes.find((s) => s.key === key)!);
  let more = await confirm({message: 'Add a custom spoke address?', default: false});
  while (more) {
    result.push(await customSpoke(m));
    more = await confirm({message: 'Add another custom spoke address?', default: false});
  }
  return result;
}
