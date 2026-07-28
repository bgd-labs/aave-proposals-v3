import {confirm} from '@inquirer/prompts';
import {Hex, isHex} from 'viem';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubAssetListing} from '../../types';
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

/// ERC-1967 admin storage slot, used by tests to read a TokenizationSpoke ProxyAdmin.
const ERC1967_ADMIN_SLOT_CONST =
  'bytes32 internal constant ERC1967_ADMIN_SLOT = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;';

function hubAssetKey(hubAccessor: string, underlying: string) {
  const hubKey = accessorIdentifier(hubAccessor);
  return {hubKey, assetKey: assetIdentifier(underlying)};
}

/// Escape a string for a single-quoted Solidity literal. Backslashes first, so the
/// escapes added for quotes are not themselves escaped.
function esc(s: string): string {
  return s.replace(/\\/g, '\\\\').replace(/'/g, "\\'");
}

/// Build the shared test helper that locates the TokenizationSpoke this payload deploys:
/// the only Spoke kind exposing `asset()`, so a successful call over the listed underlying
/// identifies it among the asset's Spokes on the Hub. Iterating backwards returns the most
/// recently registered one, which is the payload's even when the asset already had a
/// TokenizationSpoke that this listing replaces.
function tokenizationSpokeHelper(c: V4HubAssetListing, hubKey: string, assetKey: string): string {
  const underlying = testAddressRef(c.underlying);
  return `/// @dev The TokenizationSpoke is the only Spoke kind exposing \`asset()\`; scanning the
  /// Hub's spokes for this asset backwards returns the most recently registered one, which is
  /// the one this payload deploys even if the asset already had a TokenizationSpoke.
  function _findTokenizationSpoke_${hubKey}_${assetKey}() internal view returns (address) {
    IHub hub = IHub(${wrapAddress(c.hubLib)});
    uint256 assetId = hub.getAssetId(${underlying});
    for (uint256 i = hub.getSpokeCount(assetId); i > 0; --i) {
      address spoke = hub.getSpokeAddress(assetId, i - 1);
      try ITokenizationSpoke(spoke).asset() returns (address tokenized) {
        if (tokenized == ${underlying}) return spoke;
      } catch {}
    }
    revert('tokenization spoke not found');
  }`;
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
        await promptHubAssetListing(m, {hubLib: hub.expr, hub: hub.key, underlying: asset.expr}),
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
        irData: IAssetInterestRateStrategy.InterestRateData({
          optimalUsageRatio: uint16(${renderBpsSentinel(c.irData.optimalUsageRatio)}),
          baseDrawnRate: uint32(${renderBpsSentinel(c.irData.baseDrawnRate)}),
          rateGrowthBeforeOptimal: uint32(${renderBpsSentinel(c.irData.rateGrowthBeforeOptimal)}),
          rateGrowthAfterOptimal: uint32(${renderBpsSentinel(c.irData.rateGrowthAfterOptimal)})
        }),
        tokenization: IConfigEngine.TokenizationSpokeConfig({
          addCap: ${c.tokenization ? groupThousands(c.tokenization.addCap) : '0'},
          proxyAdminOwner: ${c.tokenization ? wrapAddress(c.tokenization.proxyAdminOwner) : 'address(0)'},
          name: '${c.tokenization ? esc(c.tokenization.name) : ''}',
          symbol: '${c.tokenization ? esc(c.tokenization.symbol) : ''}'
        })
      });`,
    );

    const inputAsserts = prepared.map(({c, irStrategyTestRef}) => {
      const lines = [
        `assertEq(items[__INDEX__].hub, ${wrapAddress(c.hubLib)}, 'hub');`,
        `assertEq(items[__INDEX__].underlying, ${testAddressRef(c.underlying)}, 'underlying');`,
        `assertEq(items[__INDEX__].feeReceiver, ${testAddressRef(c.feeReceiver)}, 'feeReceiver');`,
        `assertEq(items[__INDEX__].liquidityFee, ${percentToBps(c.liquidityFee)}, 'liquidityFee');`,
        `assertEq(items[__INDEX__].irStrategy, ${irStrategyTestRef}, 'irStrategy');`,
        `assertEq(uint256(items[__INDEX__].irData.optimalUsageRatio), ${renderBpsSentinel(c.irData.optimalUsageRatio)}, 'optimalUsageRatio');`,
        `assertEq(uint256(items[__INDEX__].irData.baseDrawnRate), ${renderBpsSentinel(c.irData.baseDrawnRate)}, 'baseDrawnRate');`,
        `assertEq(uint256(items[__INDEX__].irData.rateGrowthBeforeOptimal), ${renderBpsSentinel(c.irData.rateGrowthBeforeOptimal)}, 'rateGrowthBeforeOptimal');`,
        `assertEq(uint256(items[__INDEX__].irData.rateGrowthAfterOptimal), ${renderBpsSentinel(c.irData.rateGrowthAfterOptimal)}, 'rateGrowthAfterOptimal');`,
      ];
      if (c.tokenization) {
        lines.push(
          `assertEq(items[__INDEX__].tokenization.addCap, ${groupThousands(c.tokenization.addCap)}, 'tokenization addCap');`,
          `assertEq(items[__INDEX__].tokenization.proxyAdminOwner, ${testAddressRef(c.tokenization.proxyAdminOwner)}, 'tokenization proxyAdminOwner');`,
          `assertEq(items[__INDEX__].tokenization.name, '${esc(c.tokenization.name)}', 'tokenization name');`,
          `assertEq(items[__INDEX__].tokenization.symbol, '${esc(c.tokenization.symbol)}', 'tokenization symbol');`,
        );
      }
      return lines.join('\n        ');
    });

    const helpers: string[] = [];
    const testFns = prepared.map(({c, hubKey, assetKey, irStrategyTestRef}) => {
      const underlying = testAddressRef(c.underlying);
      let tokenizationAsserts = '';
      if (c.tokenization) {
        helpers.push(tokenizationSpokeHelper(c, hubKey, assetKey));
        tokenizationAsserts = `
        address tokenizationSpoke = _findTokenizationSpoke_${hubKey}_${assetKey}();
        IHub.SpokeConfig memory tokenizationCfg = hub.getSpokeConfig(assetId, tokenizationSpoke);
        assertEq(uint256(tokenizationCfg.addCap), uint256(${groupThousands(c.tokenization.addCap)}), 'tokenization addCap mismatch');
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
        assertEq(uint256(irData.optimalUsageRatio), uint256(${renderBpsSentinel(c.irData.optimalUsageRatio)}), 'optimalUsageRatio mismatch');
        assertEq(uint256(irData.baseDrawnRate), uint256(${renderBpsSentinel(c.irData.baseDrawnRate)}), 'baseDrawnRate mismatch');
        assertEq(uint256(irData.rateGrowthBeforeOptimal), uint256(${renderBpsSentinel(c.irData.rateGrowthBeforeOptimal)}), 'rateGrowthBeforeOptimal mismatch');
        assertEq(uint256(irData.rateGrowthAfterOptimal), uint256(${renderBpsSentinel(c.irData.rateGrowthAfterOptimal)}), 'rateGrowthAfterOptimal mismatch');${tokenizationAsserts}
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
        address tokenizationSpoke = _findTokenizationSpoke_${hubKey}_${assetKey}();
        address proxyAdmin = address(uint160(uint256(vm.load(tokenizationSpoke, ERC1967_ADMIN_SLOT))));
        assertEq(Ownable(proxyAdmin).owner(), ${testAddressRef(c.tokenization!.proxyAdminOwner)}, 'proxyAdmin owner mismatch');
      }`,
      );
    if (proxyAdminTests.length > 0) helpers.push(ERC1967_ADMIN_SLOT_CONST);

    // e2e-test each payload-deployed TokenizationSpoke; the default suite only covers
    // tokenization spokes already in the address book.
    const e2eTests = prepared
      .filter(({c}) => c.tokenization)
      .map(
        ({
          hubKey,
          assetKey,
        }) => `function test_e2e_tokenizationSpoke_${hubKey}_${assetKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        e2eTestTokenizationSpoke(ITokenizationSpoke(_findTokenizationSpoke_${hubKey}_${assetKey}()));
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
      test: {fn: [...testFns, ...proxyAdminTests, ...e2eTests], helpers},
    };
    return response;
  },
};
