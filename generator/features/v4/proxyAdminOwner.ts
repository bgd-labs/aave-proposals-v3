import {confirm} from '@inquirer/prompts';
import * as addressBook from '@aave-dao/aave-address-book';
import {MarketIdentifierV4} from '../../types';
import {getMarketChain} from '../../common';
import {addressPrompt} from '../../prompts/addressPrompt';

/// Prompts for a TokenizationSpoke proxy admin owner. Defaults to the market
/// chain's Executor LVL1 (with the option to override with a custom address).
export async function promptProxyAdminOwner(m: MarketIdentifierV4): Promise<string> {
  const chain = getMarketChain(m);
  const executor = (addressBook as Record<string, {EXECUTOR_LVL_1?: string}>)[
    `GovernanceV3${chain}`
  ]?.EXECUTOR_LVL_1;
  if (executor) {
    const useExecutor = await confirm({
      message: `Use Executor LVL1 (${executor}) as TokenizationSpoke proxy admin owner?`,
      default: true,
    });
    if (useExecutor) return `GovernanceV3${chain}.EXECUTOR_LVL_1`;
  }
  return addressPrompt({message: 'TokenizationSpoke proxy admin owner', required: true});
}
