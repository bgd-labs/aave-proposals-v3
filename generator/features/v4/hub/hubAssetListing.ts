import {select, input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubAssetListing} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {hubKeys, assetKeys, hubLibAccessor, assetLibAccessor, getV4Book} from '../marketBook';
import {literal} from '../sentinels';
import {buildAddressConstant} from '../constants';
import {solAddress} from '../testHelpers';

function hubAssetKey(hubAccessor: string, assetAccessor: string) {
  const hubKey = hubAccessor.split('.').pop()!;
  const assetKey = assetAccessor
    .split('.')
    .pop()!
    .replace(/_UNDERLYING$/, '');
  return {hubKey, assetKey};
}

export const hubAssetListing: FeatureModule<V4HubAssetListing[]> = {
  value: FEATURE.V4_HUB_ASSET_LISTING,
  description: 'Hub: list a new asset (with optional TokenizationSpoke)',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const book = getV4Book(m);
    const response: V4HubAssetListing[] = [];
    let more = true;
    while (more) {
      const hub = await select({
        message: 'Select hub',
        choices: hubKeys(m).map((k) => ({name: k, value: k})),
      });
      const asset = await select({
        message: 'Select asset',
        choices: assetKeys(m).map((k) => ({name: k, value: k})),
      });
      const feeReceiver = await addressPrompt({
        message: 'Fee receiver (Spoke address)',
        required: true,
      });
      const liquidityFee = (await numberPrompt({message: 'liquidityFee (bps)'})) || '0';
      const irStrategy = await addressPrompt({
        message: 'IR strategy address',
        required: true,
      });
      const optimalUsageRatio =
        (await numberPrompt({message: 'optimalUsageRatio (bps, uint16)'})) || '0';
      const baseDrawnRate = (await numberPrompt({message: 'baseDrawnRate (bps, uint32)'})) || '0';
      const rateGrowthBeforeOptimal =
        (await numberPrompt({message: 'rateGrowthBeforeOptimal (bps, uint32)'})) || '0';
      const rateGrowthAfterOptimal =
        (await numberPrompt({message: 'rateGrowthAfterOptimal (bps, uint32)'})) || '0';
      const withTokenization = await confirm({
        message: 'Deploy a TokenizationSpoke for this asset?',
        default: false,
      });
      let tokenization: V4HubAssetListing['tokenization'];
      if (withTokenization) {
        const addCap = (await numberPrompt({message: 'TokenizationSpoke addCap'})) || '0';
        const name = await input({message: 'TokenizationSpoke name'});
        const symbol = await input({message: 'TokenizationSpoke symbol'});
        tokenization = {addCap, name, symbol};
      }
      response.push({
        hubLib: hubLibAccessor(m, hub),
        hub: hub,
        underlying: assetLibAccessor(m, asset),
        feeReceiver: feeReceiver as `0x${string}`,
        liquidityFee,
        irStrategy: irStrategy as `0x${string}`,
        irData: {
          optimalUsageRatio: literal(optimalUsageRatio),
          baseDrawnRate: literal(baseDrawnRate),
          rateGrowthBeforeOptimal: literal(rateGrowthBeforeOptimal),
          rateGrowthAfterOptimal: literal(rateGrowthAfterOptimal),
        },
        tokenization,
      });
      more = await confirm({message: 'Add another listing?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const constants: string[] = [];
    const entries = cfg.map((c) => {
      const {hubKey, assetKey} = hubAssetKey(c.hubLib, c.underlying);
      const feeReceiverName = `${hubKey}_${assetKey}_FEE_RECEIVER`;
      const irStrategyName = `${hubKey}_${assetKey}_IR_STRATEGY`;
      constants.push(buildAddressConstant(market, feeReceiverName, c.feeReceiver));
      constants.push(buildAddressConstant(market, irStrategyName, c.irStrategy));
      return `items[__INDEX__] = IAaveV4ConfigEngine.AssetListing({
        hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
        hub: address(${c.hubLib}),
        underlying: ${solAddress(c.underlying)},
        feeReceiver: ${feeReceiverName},
        liquidityFee: ${c.liquidityFee.replace(/\B(?=(\d{3})+(?!\d))/g, '_')},
        irStrategy: ${irStrategyName},
        irData: IAssetInterestRateStrategy.InterestRateData({
          optimalUsageRatio: uint16(${(c.irData.optimalUsageRatio as any).value}),
          baseDrawnRate: uint32(${(c.irData.baseDrawnRate as any).value}),
          rateGrowthBeforeOptimal: uint32(${(c.irData.rateGrowthBeforeOptimal as any).value}),
          rateGrowthAfterOptimal: uint32(${(c.irData.rateGrowthAfterOptimal as any).value})
        }),
        tokenization: IAaveV4ConfigEngine.TokenizationSpokeConfig({
          addCap: ${c.tokenization ? c.tokenization.addCap : '0'},
          name: '${c.tokenization ? c.tokenization.name.replace(/'/g, "\\'") : ''}',
          symbol: '${c.tokenization ? c.tokenization.symbol.replace(/'/g, "\\'") : ''}'
        })
      });`;
    });
    const testFns = cfg.map((c) => {
      const {hubKey, assetKey} = hubAssetKey(c.hubLib, c.underlying);
      const feeReceiverName = `${hubKey}_${assetKey}_FEE_RECEIVER`;
      const irStrategyName = `${hubKey}_${assetKey}_IR_STRATEGY`;
      const liquidityFee = c.liquidityFee.replace(/\B(?=(\d{3})+(?!\d))/g, '_');
      return `function test_hubAssetListing_${hubKey}_${assetKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        IHub hub = IHub(address(${c.hubLib}));
        assertTrue(hub.isUnderlyingListed(${solAddress(c.underlying)}), 'asset not listed');
        uint256 assetId = hub.getAssetId(${solAddress(c.underlying)});
        IHub.Asset memory asset = hub.getAsset(assetId);
        IHub.AssetConfig memory cfg = hub.getAssetConfig(assetId);
        assertEq(cfg.feeReceiver, proposal.${feeReceiverName}(), 'feeReceiver mismatch');
        assertEq(cfg.irStrategy, proposal.${irStrategyName}(), 'irStrategy mismatch');
        assertEq(uint256(cfg.liquidityFee), uint256(${liquidityFee}), 'liquidityFee mismatch');
        assertEq(asset.underlying, ${solAddress(c.underlying)}, 'underlying mismatch');
      }`;
    });
    const response: CodeArtifact = {
      code: {
        constants,
        v4Getters: {
          hubAssetListings: {
            returnType: 'IAaveV4ConfigEngine.AssetListing',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
