import {confirm} from '@inquirer/prompts';
import {MarketIdentifierV4} from '../../types';
import {addressPrompt} from '../../prompts/addressPrompt';
import {treasurySpoke} from './marketBook';
import {resolveEntity} from './entityInput';

/// Prompts for an asset's fee receiver and returns a Solidity codegen expression.
/// Defaults to the market's deployed TreasurySpoke (`<Market>.TREASURY_SPOKE`), with
/// the option to override; a custom address is reverse-resolved against the address
/// book or emitted as a labeled constant.
export async function promptFeeReceiver(m: MarketIdentifierV4): Promise<string> {
  const treasury = treasurySpoke(m);
  if (treasury) {
    const useTreasury = await confirm({
      message: `Use TreasurySpoke (${treasury.address}) as fee receiver?`,
      default: true,
    });
    if (useTreasury) return `${m}.TREASURY_SPOKE`;
  }
  const value = await addressPrompt({message: 'Fee receiver (Spoke address)', required: true});
  return (await resolveEntity(m, value, 'spoke')).expr;
}
