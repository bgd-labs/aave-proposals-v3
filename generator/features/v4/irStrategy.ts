import {select} from '@inquirer/prompts';
import {getAddress} from 'viem';
import {MarketIdentifierV4} from '../../types';
import {addressPrompt} from '../../prompts/addressPrompt';
import {getV4Book} from './marketBook';
import {resolveKnownAddress} from './resolveKnownAddress';

const CUSTOM = '__custom__';

/// Prompts for an interest rate strategy and returns a Solidity codegen expression:
/// an `<Market>IRStrategies.<KEY>` accessor for a known strategy, an address-book
/// accessor for a reverse-resolved custom address, or a raw checksummed literal that
/// the listing build emits as a per-listing named constant.
export async function promptIrStrategy(m: MarketIdentifierV4): Promise<string> {
  const strategies = Object.keys((getV4Book(m) as any).IR_STRATEGIES ?? {});
  const choice = await select({
    message: 'IR strategy',
    choices: [
      ...strategies.map((k) => ({name: k, value: k})),
      {name: 'Custom address…', value: CUSTOM},
    ],
  });
  if (choice !== CUSTOM) return `${m}IRStrategies.${choice}`;
  const address = await addressPrompt({message: 'IR strategy address', required: true});
  return resolveKnownAddress(m, address)?.expr ?? getAddress(address);
}
