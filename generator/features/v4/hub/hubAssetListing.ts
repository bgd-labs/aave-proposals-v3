import {input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubAssetListing} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {selectHub} from '../hubSpokeSelect';
import {literal, renderSentinel} from '../sentinels';
import {buildAddressConstant} from '../constants';
import {accessorIdentifier, assetIdentifier, checksumAddress} from '../testHelpers';
import {selectAsset} from '../assetSelect';
import {promptFeeReceiver} from '../feeReceiver';
import {promptProxyAdminOwner} from '../proxyAdminOwner';

function hubAssetKey(hubAccessor: string, underlying: string) {
  const hubKey = accessorIdentifier(hubAccessor);
  return {hubKey, assetKey: assetIdentifier(underlying)};
}

export const hubAssetListing: FeatureModule<V4HubAssetListing[]> = {
  value: FEATURE.V4_HUB_ASSET_LISTING,
  description: 'Hub: list a new asset (with optional TokenizationSpoke)',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4HubAssetListing[] = [];
    let more = true;
    while (more) {
      const hub = await selectHub(m);
      const asset = await selectAsset(m);
      const feeReceiver = await promptFeeReceiver(m);
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
        const proxyAdminOwner = await promptProxyAdminOwner(m);
        const name = await input({message: 'TokenizationSpoke name'});
        const symbol = await input({message: 'TokenizationSpoke symbol'});
        tokenization = {addCap, proxyAdminOwner, name, symbol};
      }
      response.push({
        hubLib: hub.expr,
        hub: hub.key,
        underlying: asset.expr,
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
      return `items[__INDEX__] = IConfigEngine.AssetListing({
        hubConfigurator: ${market}.HUB_CONFIGURATOR,
        hub: address(${c.hubLib}),
        underlying: ${checksumAddress(c.underlying)},
        feeReceiver: ${feeReceiverName},
        liquidityFee: ${c.liquidityFee.replace(/\B(?=(\d{3})+(?!\d))/g, '_')},
        irStrategy: ${irStrategyName},
        irData: IAssetInterestRateStrategy.InterestRateData({
          optimalUsageRatio: uint16(${renderSentinel(c.irData.optimalUsageRatio)}),
          baseDrawnRate: uint32(${renderSentinel(c.irData.baseDrawnRate)}),
          rateGrowthBeforeOptimal: uint32(${renderSentinel(c.irData.rateGrowthBeforeOptimal)}),
          rateGrowthAfterOptimal: uint32(${renderSentinel(c.irData.rateGrowthAfterOptimal)})
        }),
        tokenization: IConfigEngine.TokenizationSpokeConfig({
          addCap: ${c.tokenization ? c.tokenization.addCap : '0'},
          proxyAdminOwner: ${c.tokenization ? checksumAddress(c.tokenization.proxyAdminOwner) : 'address(0)'},
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
      const underlying = checksumAddress(c.underlying);
      const tokenizationAsserts = c.tokenization
        ? `
        address tokenizationSpoke = hub.getSpokeAddress(assetId, 0);
        IHub.SpokeConfig memory tokenizationCfg = hub.getSpokeConfig(assetId, tokenizationSpoke);
        assertEq(uint256(tokenizationCfg.addCap), uint256(${c.tokenization.addCap}), 'tokenization addCap mismatch');
        assertEq(IERC20Metadata(tokenizationSpoke).name(), '${c.tokenization.name.replace(/'/g, "\\'")}', 'tokenization name mismatch');
        assertEq(IERC20Metadata(tokenizationSpoke).symbol(), '${c.tokenization.symbol.replace(/'/g, "\\'")}', 'tokenization symbol mismatch');`
        : '';
      return `function test_hubAssetListing_${hubKey}_${assetKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        IHub hub = IHub(address(${c.hubLib}));
        assertTrue(hub.isUnderlyingListed(${underlying}), 'asset not listed');
        uint256 assetId = hub.getAssetId(${underlying});
        IHub.Asset memory asset = hub.getAsset(assetId);
        IHub.AssetConfig memory cfg = hub.getAssetConfig(assetId);
        assertEq(asset.underlying, ${underlying}, 'underlying mismatch');
        assertEq(uint256(asset.decimals), IERC20Metadata(${underlying}).decimals(), 'decimals mismatch');
        assertEq(cfg.feeReceiver, proposal.${feeReceiverName}(), 'feeReceiver mismatch');
        assertEq(cfg.irStrategy, proposal.${irStrategyName}(), 'irStrategy mismatch');
        assertEq(uint256(cfg.liquidityFee), uint256(${liquidityFee}), 'liquidityFee mismatch');
        IAssetInterestRateStrategy.InterestRateData memory irData = IAssetInterestRateStrategy(cfg.irStrategy).getInterestRateData(assetId);
        assertEq(uint256(irData.optimalUsageRatio), uint256(${renderSentinel(c.irData.optimalUsageRatio)}), 'optimalUsageRatio mismatch');
        assertEq(uint256(irData.baseDrawnRate), uint256(${renderSentinel(c.irData.baseDrawnRate)}), 'baseDrawnRate mismatch');
        assertEq(uint256(irData.rateGrowthBeforeOptimal), uint256(${renderSentinel(c.irData.rateGrowthBeforeOptimal)}), 'rateGrowthBeforeOptimal mismatch');
        assertEq(uint256(irData.rateGrowthAfterOptimal), uint256(${renderSentinel(c.irData.rateGrowthAfterOptimal)}), 'rateGrowthAfterOptimal mismatch');${tokenizationAsserts}
      }`;
    });
    const response: CodeArtifact = {
      code: {
        constants,
        v4Getters: {
          hubAssetListings: {
            returnType: 'IConfigEngine.AssetListing',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
