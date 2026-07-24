import {input, confirm} from '@inquirer/prompts';
import {MarketIdentifierV4} from '../../../types';
import {V4HubAssetListing} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {percentPrompt} from '../../../prompts/percentPrompt';
import {literal} from '../sentinels';
import {promptFeeReceiver} from '../feeReceiver';
import {promptProxyAdminOwner} from '../proxyAdminOwner';
import {promptIrStrategy} from '../irStrategy';

/// Shared prompt flow for listing an asset on a Hub. Collects fee receiver, IR
/// strategy and interest rate data (as human percentages), and an optional
/// TokenizationSpoke. Offers a non-borrowable collateral preset that fills the
/// documented convention (optimalUsageRatio 99%, all rates 0, liquidityFee 0).
export async function promptHubAssetListing(
  m: MarketIdentifierV4,
  entity: {hubLib: string; hub: string; underlying: string},
): Promise<V4HubAssetListing> {
  const feeReceiver = await promptFeeReceiver(m);
  const irStrategy = await promptIrStrategy(m);

  const nonBorrowable = await confirm({
    message:
      'Non-borrowable collateral preset (optimalUsageRatio 99%, all rates 0, liquidityFee 0)?',
    default: false,
  });
  let liquidityFee = '0';
  let optimalUsageRatio = '99';
  let baseDrawnRate = '0';
  let rateGrowthBeforeOptimal = '0';
  let rateGrowthAfterOptimal = '0';
  if (!nonBorrowable) {
    liquidityFee = (await percentPrompt({message: 'liquidityFee (%)'})) || '0';
    optimalUsageRatio = (await percentPrompt({message: 'optimalUsageRatio (%)'})) || '0';
    baseDrawnRate = (await percentPrompt({message: 'baseDrawnRate (%)'})) || '0';
    rateGrowthBeforeOptimal =
      (await percentPrompt({message: 'rateGrowthBeforeOptimal (%)'})) || '0';
    rateGrowthAfterOptimal = (await percentPrompt({message: 'rateGrowthAfterOptimal (%)'})) || '0';
  }

  const withTokenization = await confirm({
    message: 'Deploy a TokenizationSpoke for this asset?',
    default: false,
  });
  let tokenization: V4HubAssetListing['tokenization'];
  if (withTokenization) {
    tokenization = {
      addCap: (await numberPrompt({message: 'TokenizationSpoke addCap (whole units)'})) || '0',
      proxyAdminOwner: await promptProxyAdminOwner(m),
      name: await input({message: 'TokenizationSpoke name'}),
      symbol: await input({message: 'TokenizationSpoke symbol'}),
    };
  }

  return {
    hubLib: entity.hubLib,
    hub: entity.hub,
    underlying: entity.underlying,
    feeReceiver,
    liquidityFee,
    irStrategy,
    irData: {
      optimalUsageRatio: literal(optimalUsageRatio),
      baseDrawnRate: literal(baseDrawnRate),
      rateGrowthBeforeOptimal: literal(rateGrowthBeforeOptimal),
      rateGrowthAfterOptimal: literal(rateGrowthAfterOptimal),
    },
    tokenization,
  };
}
