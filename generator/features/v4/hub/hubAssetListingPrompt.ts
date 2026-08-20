import {Hex} from 'viem';
import {input, confirm} from '@inquirer/prompts';
import {MarketIdentifierV4} from '../../../types';
import {V4HubAssetListing} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {percentPrompt} from '../../../prompts/percentPrompt';
import {literal} from '../sentinels';
import {promptFeeReceiver} from '../feeReceiver';
import {promptProxyAdminOwner} from '../proxyAdminOwner';
import {promptIrStrategy} from '../irStrategy';
import {hubDisplayName} from '../labelRegistry';
import {readErc20Symbol} from '../onchain';

const nonEmpty = (v: string) => v.trim().length > 0 || 'A value is required';

/// Shared prompt flow for listing an asset on a Hub. Collects fee receiver, IR
/// strategy and interest rate data (as human percentages), and an optional
/// TokenizationSpoke. Offers the non-borrowable collateral preset, which lets
/// `V4EngineDefaults` hold the drawn rate at 0 instead of collecting rates.
export async function promptHubAssetListing(
  m: MarketIdentifierV4,
  entity: {hubLib: string; hub: string; underlying: string; underlyingAddress: Hex},
): Promise<V4HubAssetListing> {
  const feeReceiver = await promptFeeReceiver(m);
  const irStrategy = await promptIrStrategy(m);

  const nonBorrowable = await confirm({
    message:
      'Non-borrowable collateral preset (V4EngineDefaults.nonBorrowableIRData(), liquidityFee 0)?',
    default: false,
  });
  let liquidityFee = '0';
  let irData: V4HubAssetListing['irData'];
  if (!nonBorrowable) {
    liquidityFee = (await percentPrompt({message: 'liquidityFee (%)'})) || '0';
    irData = {
      optimalUsageRatio: literal((await percentPrompt({message: 'optimalUsageRatio (%)'})) || '0'),
      baseDrawnRate: literal((await percentPrompt({message: 'baseDrawnRate (%)'})) || '0'),
      rateGrowthBeforeOptimal: literal(
        (await percentPrompt({message: 'rateGrowthBeforeOptimal (%)'})) || '0',
      ),
      rateGrowthAfterOptimal: literal(
        (await percentPrompt({message: 'rateGrowthAfterOptimal (%)'})) || '0',
      ),
    };
  }

  const withTokenization = await confirm({
    message: 'Deploy a TokenizationSpoke for this asset?',
    default: false,
  });
  let tokenization: V4HubAssetListing['tokenization'];
  if (withTokenization) {
    const hubName = hubDisplayName(entity.hub);
    const symbol = await readErc20Symbol(m, entity.underlyingAddress);
    // the preset caps a non-borrowable asset's wrapper at 0, so there is nothing to collect
    const addCap = nonBorrowable
      ? '0'
      : (await numberPrompt({message: 'TokenizationSpoke addCap (whole units)'})) || '0';
    tokenization = {
      addCap,
      proxyAdminOwner: await promptProxyAdminOwner(m),
      // an empty name reverts the deployment in HubEngine._deployAndRegisterTokenizationSpoke
      name: await input({
        message: 'TokenizationSpoke name',
        default: `Wrapped Aave ${hubName} ${symbol}`,
        validate: nonEmpty,
      }),
      symbol: await input({
        message: 'TokenizationSpoke symbol',
        default: `wa${hubName.replace(/\s/g, '')}${symbol}`,
        validate: nonEmpty,
      }),
    };
  }

  return {
    hubLib: entity.hubLib,
    hub: entity.hub,
    underlying: entity.underlying,
    feeReceiver,
    liquidityFee,
    irStrategy,
    ...(nonBorrowable ? {irPreset: 'nonBorrowable' as const} : {irData}),
    tokenization,
  };
}
