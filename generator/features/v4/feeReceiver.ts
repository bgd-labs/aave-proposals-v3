import {confirm} from '@inquirer/prompts';
import {Hex} from 'viem';
import {MarketIdentifierV4} from '../../types';
import {addressPrompt} from '../../prompts/addressPrompt';
import {treasurySpoke} from './marketBook';

/// Prompts for an asset's fee receiver. Defaults to the market's deployed
/// TreasurySpoke (with the option to override), or falls back to a required
/// address input when no TreasurySpoke is deployed.
export async function promptFeeReceiver(m: MarketIdentifierV4): Promise<Hex> {
  const treasury = treasurySpoke(m);
  if (treasury) {
    const useTreasury = await confirm({
      message: `Use TreasurySpoke (${treasury.address}) as fee receiver?`,
      default: true,
    });
    if (useTreasury) return treasury.address as Hex;
  }
  const value = await addressPrompt({message: 'Fee receiver (Spoke address)', required: true});
  return value as Hex;
}
