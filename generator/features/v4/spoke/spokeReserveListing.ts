import {confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4SpokeReserveListing} from '../../types';
import {percentPrompt} from '../../../prompts/percentPrompt';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {selectHub, selectSpoke} from '../hubSpokeSelect';
import {buildAddressConstant} from '../constants';
import {
  accessorIdentifier,
  assetIdentifier,
  checksumAddress,
  testAddressRef,
  wrapAddress,
} from '../testHelpers';
import {percentToBps} from '../units';
import {selectAsset} from '../assetSelect';

function priceFeedConstantName(spokeAccessor: string, underlying: string): string {
  return `${accessorIdentifier(spokeAccessor)}_${assetIdentifier(underlying)}_PRICE_FEED`;
}

export const spokeReserveListing: FeatureModule<V4SpokeReserveListing[]> = {
  value: FEATURE.V4_SPOKE_RESERVE_LISTING,
  description: 'Spoke: list a new reserve',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4SpokeReserveListing[] = [];
    let more = true;
    while (more) {
      const hub = await selectHub(m);
      const spoke = await selectSpoke(m);
      const asset = await selectAsset(m);
      const priceSource = await addressPrompt({message: 'Price source', required: true});
      const config = {
        collateralRisk: (await percentPrompt({message: 'collateralRisk (%)'})) || '0',
        paused: false,
        frozen: false,
        borrowable: true,
        receiveSharesEnabled: true,
      };
      const customize = await confirm({
        message: 'Customize reserve flags (paused/frozen/borrowable/receiveShares)?',
        default: false,
      });
      if (customize) {
        config.paused = await confirm({message: 'paused?', default: false});
        config.frozen = await confirm({message: 'frozen?', default: false});
        config.borrowable = await confirm({message: 'borrowable?', default: true});
        config.receiveSharesEnabled = await confirm({
          message: 'receiveSharesEnabled?',
          default: true,
        });
      }
      response.push({
        spokeLib: spoke.expr,
        spoke: spoke.expr,
        hub: hub.expr,
        underlying: asset.expr,
        priceSource: priceSource as `0x${string}`,
        config,
        dynamicConfig: {
          collateralFactor: (await percentPrompt({message: 'collateralFactor (%)'})) || '0',
          maxLiquidationBonus:
            (await percentPrompt({message: 'maxLiquidationBonus (%, full value e.g. 104)'})) || '0',
          liquidationFee: (await percentPrompt({message: 'liquidationFee (%)'})) || '0',
        },
      });
      more = await confirm({message: 'Add another reserve listing?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const constants = cfg.map((c) =>
      buildAddressConstant(market, priceFeedConstantName(c.spoke, c.underlying), c.priceSource),
    );
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.ReserveListing({
        spokeConfigurator: ${market}.SPOKE_CONFIGURATOR,
        spoke: ${wrapAddress(c.spoke)},
        hub: ${wrapAddress(c.hub)},
        underlying: ${checksumAddress(c.underlying)},
        priceSource: ${priceFeedConstantName(c.spoke, c.underlying)},
        config: ISpoke.ReserveConfig({
          collateralRisk: uint24(${percentToBps(c.config.collateralRisk)}),
          paused: ${c.config.paused},
          frozen: ${c.config.frozen},
          borrowable: ${c.config.borrowable},
          receiveSharesEnabled: ${c.config.receiveSharesEnabled}
        }),
        dynamicConfig: ISpoke.DynamicReserveConfig({
          collateralFactor: uint16(${percentToBps(c.dynamicConfig.collateralFactor)}),
          maxLiquidationBonus: uint32(${percentToBps(c.dynamicConfig.maxLiquidationBonus)}),
          liquidationFee: uint16(${percentToBps(c.dynamicConfig.liquidationFee)})
        })
      });`,
    );
    const inputAsserts = cfg.map((c) =>
      [
        `assertEq(items[__INDEX__].spoke, ${testAddressRef(c.spoke)}, 'spoke');`,
        `assertEq(items[__INDEX__].hub, ${wrapAddress(c.hub)}, 'hub');`,
        `assertEq(items[__INDEX__].underlying, ${testAddressRef(c.underlying)}, 'underlying');`,
        `assertEq(items[__INDEX__].priceSource, proposal.${priceFeedConstantName(c.spoke, c.underlying)}(), 'priceSource');`,
        `assertEq(uint256(items[__INDEX__].config.collateralRisk), ${percentToBps(c.config.collateralRisk)}, 'collateralRisk');`,
        `assertEq(items[__INDEX__].config.paused, ${c.config.paused}, 'paused');`,
        `assertEq(items[__INDEX__].config.frozen, ${c.config.frozen}, 'frozen');`,
        `assertEq(items[__INDEX__].config.borrowable, ${c.config.borrowable}, 'borrowable');`,
        `assertEq(items[__INDEX__].config.receiveSharesEnabled, ${c.config.receiveSharesEnabled}, 'receiveSharesEnabled');`,
        `assertEq(uint256(items[__INDEX__].dynamicConfig.collateralFactor), ${percentToBps(c.dynamicConfig.collateralFactor)}, 'collateralFactor');`,
        `assertEq(uint256(items[__INDEX__].dynamicConfig.maxLiquidationBonus), ${percentToBps(c.dynamicConfig.maxLiquidationBonus)}, 'maxLiquidationBonus');`,
        `assertEq(uint256(items[__INDEX__].dynamicConfig.liquidationFee), ${percentToBps(c.dynamicConfig.liquidationFee)}, 'liquidationFee');`,
      ].join('\n        '),
    );
    const testFns = cfg.map((c) => {
      const spokeKey = accessorIdentifier(c.spoke);
      const assetKey = assetIdentifier(c.underlying);
      const underlying = testAddressRef(c.underlying);
      return `function test_spokeReserveListing_${spokeKey}_${assetKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        ISpoke spoke = ISpoke(${testAddressRef(c.spoke)});
        IHub hub = IHub(${wrapAddress(c.hub)});
        uint256 assetId = hub.getAssetId(${underlying});
        uint256 reserveId = spoke.getReserveId(address(hub), assetId);
        ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
        ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
        assertEq(reserve.underlying, ${underlying}, 'underlying mismatch');
        assertEq(address(reserve.hub), address(hub), 'hub mismatch');
        assertEq(uint256(reserve.assetId), assetId, 'assetId mismatch');
        assertEq(uint256(reserve.decimals), IERC20Metadata(${underlying}).decimals(), 'decimals mismatch');
        assertEq(uint256(cfg.collateralRisk), uint256(${percentToBps(c.config.collateralRisk)}), 'collateralRisk mismatch');
        assertEq(cfg.paused, ${c.config.paused}, 'paused mismatch');
        assertEq(cfg.frozen, ${c.config.frozen}, 'frozen mismatch');
        assertEq(cfg.borrowable, ${c.config.borrowable}, 'borrowable mismatch');
        assertEq(cfg.receiveSharesEnabled, ${c.config.receiveSharesEnabled}, 'receiveSharesEnabled mismatch');
        ISpoke.DynamicReserveConfig memory dyn = spoke.getDynamicReserveConfig(reserveId, reserve.dynamicConfigKey);
        assertEq(uint256(dyn.collateralFactor), uint256(${percentToBps(c.dynamicConfig.collateralFactor)}), 'collateralFactor mismatch');
        assertEq(uint256(dyn.maxLiquidationBonus), uint256(${percentToBps(c.dynamicConfig.maxLiquidationBonus)}), 'maxLiquidationBonus mismatch');
        assertEq(uint256(dyn.liquidationFee), uint256(${percentToBps(c.dynamicConfig.liquidationFee)}), 'liquidationFee mismatch');
      }`;
    });
    // One price-source test per spoke, reading back through the spoke's own oracle.
    const spokes = [...new Set(cfg.map((c) => c.spoke))];
    const priceSourceTests = spokes.map((s) => {
      const asserts = cfg
        .filter((c) => c.spoke === s)
        .map(
          (c) => `assertEq(
            oracle.getReserveSource(spoke.getReserveId(${wrapAddress(c.hub)}, IHub(${wrapAddress(c.hub)}).getAssetId(${testAddressRef(c.underlying)}))),
            proposal.${priceFeedConstantName(c.spoke, c.underlying)}(),
            '${assetIdentifier(c.underlying)} price source mismatch'
          );`,
        );
      return `function test_reservePriceSources_${accessorIdentifier(s)}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        ISpoke spoke = ISpoke(${testAddressRef(s)});
        IAaveOracle oracle = IAaveOracle(spoke.ORACLE());
        ${asserts.join('\n        ')}
      }`;
    });
    // e2e-test each payload-deployed Spoke (a bare payload constant, not an address-book
    // accessor); the default suite only covers Spokes already in the address book.
    const newSpokes = [...new Set(cfg.filter((c) => !c.spoke.includes('.')).map((c) => c.spoke))];
    const e2eTests = newSpokes.map(
      (s) => `function test_e2e_${accessorIdentifier(s)}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        e2eTestSpoke(ISpoke(${testAddressRef(s)}));
      }`,
    );
    const response: CodeArtifact = {
      code: {
        constants,
        v4Getters: {
          spokeReserveListings: {
            returnType: 'IConfigEngine.ReserveListing',
            entries,
            inputAsserts,
          },
        },
      },
      test: {fn: [...testFns, ...priceSourceTests, ...e2eTests]},
    };
    return response;
  },
};
