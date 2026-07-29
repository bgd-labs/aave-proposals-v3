import {select} from '@inquirer/prompts';
import {Hex, getAddress} from 'viem';
import {MarketIdentifierV4} from '../../types';
import {addressPrompt} from '../../prompts/addressPrompt';
import {assetKeys, assetLibAccessor, getV4Book} from './marketBook';
import {resolveEntity} from './entityInput';

const CUSTOM = '__custom__';

export type SelectedAsset = {
  /// Display label used for prompt messages.
  label: string;
  /// Raw underlying address, used for on-chain reads.
  underlying: Hex;
  /// Solidity expression for codegen: a `<Market>Assets.<KEY>_UNDERLYING` accessor
  /// for book assets, or a named-constant identifier (its symbol) for a custom ERC20.
  expr: string;
  /// True for a custom ERC20 not present in the address book.
  isNew: boolean;
};

/// Prompt for an asset, allowing either a known address-book asset or a custom
/// ERC20 address not present in the lists. A custom ERC20 is labeled by its
/// on-chain symbol and emitted as a named constant.
export async function selectAsset(m: MarketIdentifierV4): Promise<SelectedAsset> {
  const book = getV4Book(m);
  const asset = await select({
    message: 'Select asset',
    choices: [
      ...assetKeys(m).map((k) => ({name: k, value: k})),
      {name: 'Custom address…', value: CUSTOM},
    ],
  });
  if (asset === CUSTOM) {
    const address = await addressPrompt({message: 'ERC20 underlying address', required: true});
    const {expr, label, isKnown} = await resolveEntity(m, address, 'asset');
    return {label, underlying: getAddress(address), expr, isNew: !isKnown};
  }
  return {
    label: asset,
    underlying: book.ASSETS[asset].UNDERLYING as Hex,
    expr: assetLibAccessor(m, asset),
    isNew: false,
  };
}
