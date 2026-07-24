import {select, input} from '@inquirer/prompts';
import {Sentinel} from '../types';
import {numberPrompt} from '../../prompts/numberPrompt';
import {percentPrompt} from '../../prompts/percentPrompt';
import {addressPrompt} from '../../prompts/addressPrompt';
import {keepCurrent, keepCurrentAddress, literal, enabled, disabled} from './sentinels';

/// Percent input -> literal (human percent, converted to BPS at build) or keepCurrent.
export async function sentinelPercent(message: string): Promise<Sentinel> {
  const v = await percentPrompt({message: `${message} (empty = keep current)`});
  return v ? literal(v) : keepCurrent();
}

/// Whole-number input -> literal or keepCurrent.
export async function sentinelWhole(message: string): Promise<Sentinel> {
  const v = await numberPrompt({message: `${message} (empty = keep current)`});
  return v ? literal(v) : keepCurrent();
}

/// Decimal (health-factor) input -> literal (converted to WAD at build) or keepCurrent.
export async function sentinelWad(message: string): Promise<Sentinel> {
  const v = await input({
    message: `${message} (empty = keep current)`,
    validate: (x) => x === '' || !isNaN(Number(x)) || 'Enter a decimal number',
  });
  return v ? literal(v) : keepCurrent();
}

export async function sentinelBool(message: string): Promise<Sentinel> {
  const choice = await select({
    message,
    choices: [
      {name: 'keep current', value: 'keep'},
      {name: 'enable', value: 'enable'},
      {name: 'disable', value: 'disable'},
    ],
    default: 'keep',
  });
  if (choice === 'enable') return enabled();
  if (choice === 'disable') return disabled();
  return keepCurrent();
}

export async function sentinelAddress(message: string): Promise<Sentinel> {
  const v = await addressPrompt({message: `${message} (empty = keep current)`});
  return v ? literal(v) : keepCurrentAddress();
}
