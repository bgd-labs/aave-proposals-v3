import {confirm} from '@inquirer/prompts';
import {Hex, isHex} from 'viem';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubAssetListing, V4InterestRateData} from '../../types';
import {groupThousands, renderBpsSentinel, percentToBps} from '../units';
import {buildAddressConstant} from '../constants';
import {
  accessorIdentifier,
  assetIdentifier,
  checksumAddress,
  testAddressRef,
  wrapAddress,
} from '../testHelpers';
import {selectHub} from '../hubSpokeSelect';
import {selectAsset} from '../assetSelect';
import {promptHubAssetListing} from './hubAssetListingPrompt';

function hubAssetKey(hubAccessor: string, underlying: string) {
  const hubKey = accessorIdentifier(hubAccessor);
  return {hubKey, assetKey: assetIdentifier(underlying)};
}

/// Escape a string for a single-quoted Solidity literal. Backslashes first, so the
/// escapes added for quotes are not themselves escaped.
function esc(s: string): string {
  return s.replace(/\\/g, '\\\\').replace(/'/g, "\\'");
}

/// The four interest rate values as Solidity expressions, from the preset or from the
/// collected percentages, so the payload and its assertions cannot drift apart.
function irValues(c: V4HubAssetListing): Record<keyof V4InterestRateData, string> {
  if (c.irPreset === 'nonBorrowable') {
    return {
      optimalUsageRatio: 'V4EngineDefaults.MAX_OPTIMAL_USAGE_RATIO',
      baseDrawnRate: '0',
      rateGrowthBeforeOptimal: '0',
      rateGrowthAfterOptimal: '0',
    };
  }
  const irData = c.irData!;
  return {
    optimalUsageRatio: renderBpsSentinel(irData.optimalUsageRatio),
    baseDrawnRate: renderBpsSentinel(irData.baseDrawnRate),
    rateGrowthBeforeOptimal: renderBpsSentinel(irData.rateGrowthBeforeOptimal),
    rateGrowthAfterOptimal: renderBpsSentinel(irData.rateGrowthAfterOptimal),
  };
}

/// Codegen for the listing's `irData` field: the preset library call, or the collected
/// values as an InterestRateData literal.
function irDataCodegen(c: V4HubAssetListing): string {
  if (c.irPreset === 'nonBorrowable') return 'V4EngineDefaults.nonBorrowableIRData()';
  const ir = irValues(c);
  return `IAssetInterestRateStrategy.InterestRateData({
          optimalUsageRatio: uint16(${ir.optimalUsageRatio}),
          baseDrawnRate: uint32(${ir.baseDrawnRate}),
          rateGrowthBeforeOptimal: uint32(${ir.rateGrowthBeforeOptimal}),
          rateGrowthAfterOptimal: uint32(${ir.rateGrowthAfterOptimal})
        })`;
}

/// The TokenizationSpoke's add cap as a Solidity expression. A non-borrowable asset accrues no
/// interest, so its wrapper has no yield to offer and is registered with no room to add.
function tokenizationAddCap(c: V4HubAssetListing): string {
  if (c.irPreset === 'nonBorrowable') return '0';
  return groupThousands(c.tokenization!.addCap);
}

/// Codegen for the listing's `tokenization` field: the config deploying an ERC4626
/// wrapper, or the preset the engine reads as "no wrapper".
function tokenizationCodegen(c: V4HubAssetListing): string {
  if (!c.tokenization) return 'V4EngineDefaults.noTokenization()';
  return `IConfigEngine.TokenizationSpokeConfig({
          addCap: ${tokenizationAddCap(c)},
          proxyAdminOwner: ${wrapAddress(c.tokenization.proxyAdminOwner)},
          name: '${esc(c.tokenization.name)}',
          symbol: '${esc(c.tokenization.symbol)}'
        })`;
}

/// Test-side expression locating the TokenizationSpoke this payload deploys. Reverts on a
/// miss, so every assertion over it fails loudly rather than reading address(0).
function tokenizationSpokeExpr(c: V4HubAssetListing): string {
  return `_getTokenizationSpoke(IHub(${wrapAddress(c.hubLib)}), ${testAddressRef(c.underlying)})`;
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
      response.push(
        await promptHubAssetListing(m, {
          hubLib: hub.expr,
          hub: hub.key,
          underlying: asset.expr,
          underlyingAddress: asset.underlying,
        }),
      );
      more = await confirm({message: 'Add another listing?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const constants: string[] = [];
    const prepared = cfg.map((c) => {
      const {hubKey, assetKey} = hubAssetKey(c.hubLib, c.underlying);
      const irIsHex = isHex(c.irStrategy) && c.irStrategy.length === 42;
      const irStrategyName = `${hubKey}_${assetKey}_IR_STRATEGY`;
      if (irIsHex)
        constants.push(buildAddressConstant(market, irStrategyName, c.irStrategy as Hex));
      return {
        c,
        hubKey,
        assetKey,
        irStrategyRef: irIsHex ? irStrategyName : wrapAddress(c.irStrategy),
        irStrategyTestRef: irIsHex ? `proposal.${irStrategyName}()` : wrapAddress(c.irStrategy),
      };
    });

    const entries = prepared.map(
      ({c, irStrategyRef}) => `items[__INDEX__] = IConfigEngine.AssetListing({
        hubConfigurator: ${market}.HUB_CONFIGURATOR,
        hub: ${wrapAddress(c.hubLib)},
        underlying: ${checksumAddress(c.underlying)},
        feeReceiver: ${wrapAddress(c.feeReceiver)},
        liquidityFee: ${percentToBps(c.liquidityFee)},
        irStrategy: ${irStrategyRef},
        irData: ${irDataCodegen(c)},
        tokenization: ${tokenizationCodegen(c)}
      });`,
    );

    const inputAsserts = prepared.map(({c, irStrategyTestRef}) => {
      const ir = irValues(c);
      const lines = [
        `assertEq(items[__INDEX__].hub, ${wrapAddress(c.hubLib)}, 'hub');`,
        `assertEq(items[__INDEX__].underlying, ${testAddressRef(c.underlying)}, 'underlying');`,
        `assertEq(items[__INDEX__].feeReceiver, ${testAddressRef(c.feeReceiver)}, 'feeReceiver');`,
        `assertEq(items[__INDEX__].liquidityFee, ${percentToBps(c.liquidityFee)}, 'liquidityFee');`,
        `assertEq(items[__INDEX__].irStrategy, ${irStrategyTestRef}, 'irStrategy');`,
        `assertEq(uint256(items[__INDEX__].irData.optimalUsageRatio), ${ir.optimalUsageRatio}, 'optimalUsageRatio');`,
        `assertEq(uint256(items[__INDEX__].irData.baseDrawnRate), ${ir.baseDrawnRate}, 'baseDrawnRate');`,
        `assertEq(uint256(items[__INDEX__].irData.rateGrowthBeforeOptimal), ${ir.rateGrowthBeforeOptimal}, 'rateGrowthBeforeOptimal');`,
        `assertEq(uint256(items[__INDEX__].irData.rateGrowthAfterOptimal), ${ir.rateGrowthAfterOptimal}, 'rateGrowthAfterOptimal');`,
      ];
      if (c.tokenization) {
        lines.push(
          `assertEq(items[__INDEX__].tokenization.addCap, ${tokenizationAddCap(c)}, 'tokenization addCap');`,
          `assertEq(items[__INDEX__].tokenization.proxyAdminOwner, ${testAddressRef(c.tokenization.proxyAdminOwner)}, 'tokenization proxyAdminOwner');`,
          `assertEq(items[__INDEX__].tokenization.name, '${esc(c.tokenization.name)}', 'tokenization name');`,
          `assertEq(items[__INDEX__].tokenization.symbol, '${esc(c.tokenization.symbol)}', 'tokenization symbol');`,
        );
      }
      return lines.join('\n        ');
    });

    const testFns = prepared.map(({c, hubKey, assetKey, irStrategyTestRef}) => {
      const underlying = testAddressRef(c.underlying);
      const ir = irValues(c);
      let tokenizationAsserts = `
        assertEq(_findTokenizationSpoke(hub, ${underlying}), address(0), 'unexpected tokenization spoke');`;
      if (c.tokenization) {
        tokenizationAsserts = `
        address tokenizationSpoke = ${tokenizationSpokeExpr(c)};
        IHub.SpokeConfig memory tokenizationCfg = hub.getSpokeConfig(assetId, tokenizationSpoke);
        assertEq(uint256(tokenizationCfg.addCap), uint256(${tokenizationAddCap(c)}), 'tokenization addCap mismatch');
        assertEq(IERC20Metadata(tokenizationSpoke).name(), '${esc(c.tokenization.name)}', 'tokenization name mismatch');
        assertEq(IERC20Metadata(tokenizationSpoke).symbol(), '${esc(c.tokenization.symbol)}', 'tokenization symbol mismatch');`;
      }
      return `function test_hubAssetListing_${hubKey}_${assetKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        IHub hub = IHub(${wrapAddress(c.hubLib)});
        assertTrue(hub.isUnderlyingListed(${underlying}), 'asset not listed');
        uint256 assetId = hub.getAssetId(${underlying});
        IHub.Asset memory asset = hub.getAsset(assetId);
        IHub.AssetConfig memory cfg = hub.getAssetConfig(assetId);
        assertEq(asset.underlying, ${underlying}, 'underlying mismatch');
        assertEq(uint256(asset.decimals), IERC20Metadata(${underlying}).decimals(), 'decimals mismatch');
        assertEq(cfg.feeReceiver, ${testAddressRef(c.feeReceiver)}, 'feeReceiver mismatch');
        assertEq(cfg.irStrategy, ${irStrategyTestRef}, 'irStrategy mismatch');
        assertEq(uint256(cfg.liquidityFee), uint256(${percentToBps(c.liquidityFee)}), 'liquidityFee mismatch');
        IAssetInterestRateStrategy.InterestRateData memory irData = IAssetInterestRateStrategy(cfg.irStrategy).getInterestRateData(assetId);
        assertEq(uint256(irData.optimalUsageRatio), uint256(${ir.optimalUsageRatio}), 'optimalUsageRatio mismatch');
        assertEq(uint256(irData.baseDrawnRate), uint256(${ir.baseDrawnRate}), 'baseDrawnRate mismatch');
        assertEq(uint256(irData.rateGrowthBeforeOptimal), uint256(${ir.rateGrowthBeforeOptimal}), 'rateGrowthBeforeOptimal mismatch');
        assertEq(uint256(irData.rateGrowthAfterOptimal), uint256(${ir.rateGrowthAfterOptimal}), 'rateGrowthAfterOptimal mismatch');${tokenizationAsserts}
      }`;
    });

    const proxyAdminTests = prepared
      .filter(({c}) => c.tokenization)
      .map(
        ({
          c,
          hubKey,
          assetKey,
        }) => `function test_tokenizationSpoke_${hubKey}_${assetKey}_proxyAdminOwner() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        assertEq(_proxyAdminOwner(${tokenizationSpokeExpr(c)}), ${testAddressRef(c.tokenization!.proxyAdminOwner)}, 'proxyAdmin owner mismatch');
      }`,
      );

    // e2e-test each payload-deployed TokenizationSpoke; the default suite only covers
    // tokenization spokes already in the address book.
    const e2eTests = prepared
      .filter(({c}) => c.tokenization)
      .map(
        ({
          c,
          hubKey,
          assetKey,
        }) => `function test_e2e_tokenizationSpoke_${hubKey}_${assetKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        e2eTestTokenizationSpoke(ITokenizationSpoke(${tokenizationSpokeExpr(c)}));
      }`,
      );

    const response: CodeArtifact = {
      code: {
        constants,
        v4Getters: {
          hubAssetListings: {
            returnType: 'IConfigEngine.AssetListing',
            entries,
            inputAsserts,
          },
        },
      },
      test: {fn: [...testFns, ...proxyAdminTests, ...e2eTests]},
    };
    return response;
  },
};
