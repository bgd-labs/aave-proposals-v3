import {select, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4SpokeReserveListing} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {hubKeys, spokeKeys, hubLibAccessor, spokeLibAccessor} from '../marketBook';
import {buildAddressConstant} from '../constants';
import {assetIdentifier, checksumAddress} from '../testHelpers';
import {selectAsset} from '../assetSelect';

function priceFeedConstantName(spokeAccessor: string, underlying: string): string {
  const spokeKey = spokeAccessor.split('.').pop()!;
  return `${spokeKey}_${assetIdentifier(underlying)}_PRICE_FEED`;
}

export const spokeReserveListing: FeatureModule<V4SpokeReserveListing[]> = {
  value: FEATURE.V4_SPOKE_RESERVE_LISTING,
  description: 'Spoke: list a new reserve',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4SpokeReserveListing[] = [];
    let more = true;
    while (more) {
      const hub = await select({
        message: 'Select hub',
        choices: hubKeys(m).map((k) => ({name: k, value: k})),
      });
      const spoke = await select({
        message: 'Select spoke',
        choices: spokeKeys(m).map((k) => ({name: k, value: k})),
      });
      const asset = await selectAsset(m);
      const priceSource = await addressPrompt({message: 'Price source', required: true});
      response.push({
        spokeLib: spokeLibAccessor(m, spoke),
        spoke: spokeLibAccessor(m, spoke),
        hub: hubLibAccessor(m, hub),
        underlying: asset.expr,
        priceSource: priceSource as `0x${string}`,
        config: {
          collateralRisk: (await numberPrompt({message: 'collateralRisk (bps, uint24)'})) || '0',
          paused: await confirm({message: 'paused?', default: false}),
          frozen: await confirm({message: 'frozen?', default: false}),
          borrowable: await confirm({message: 'borrowable?', default: true}),
          receiveSharesEnabled: await confirm({message: 'receiveSharesEnabled?', default: true}),
        },
        dynamicConfig: {
          collateralFactor:
            (await numberPrompt({message: 'collateralFactor (bps, uint16)'})) || '0',
          maxLiquidationBonus:
            (await numberPrompt({message: 'maxLiquidationBonus (bps, uint32)'})) || '0',
          liquidationFee: (await numberPrompt({message: 'liquidationFee (bps, uint16)'})) || '0',
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
        spoke: address(${c.spoke}),
        hub: address(${c.hub}),
        underlying: ${checksumAddress(c.underlying)},
        priceSource: ${priceFeedConstantName(c.spoke, c.underlying)},
        config: ISpoke.ReserveConfig({
          collateralRisk: uint24(${c.config.collateralRisk}),
          paused: ${c.config.paused},
          frozen: ${c.config.frozen},
          borrowable: ${c.config.borrowable},
          receiveSharesEnabled: ${c.config.receiveSharesEnabled}
        }),
        dynamicConfig: ISpoke.DynamicReserveConfig({
          collateralFactor: uint16(${c.dynamicConfig.collateralFactor}),
          maxLiquidationBonus: uint32(${c.dynamicConfig.maxLiquidationBonus}),
          liquidationFee: uint16(${c.dynamicConfig.liquidationFee})
        })
      });`,
    );
    const testFns = cfg.map((c) => {
      const spokeKey = c.spoke.split('.').pop()!;
      const assetKey = assetIdentifier(c.underlying);
      return `function test_spokeReserveListing_${spokeKey}_${assetKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        ISpoke spoke = ISpoke(address(${c.spoke}));
        IHub hub = IHub(address(${c.hub}));
        uint256 assetId = hub.getAssetId(${checksumAddress(c.underlying)});
        uint256 reserveId = spoke.getReserveId(address(hub), assetId);
        ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
        ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
        assertEq(reserve.underlying, ${checksumAddress(c.underlying)}, 'underlying mismatch');
        assertEq(address(reserve.hub), address(hub), 'hub mismatch');
        assertEq(uint256(reserve.assetId), assetId, 'assetId mismatch');
        assertEq(uint256(reserve.decimals), IERC20Metadata(${checksumAddress(c.underlying)}).decimals(), 'decimals mismatch');
        assertEq(uint256(cfg.collateralRisk), uint256(${c.config.collateralRisk}), 'collateralRisk mismatch');
        assertEq(cfg.paused, ${c.config.paused}, 'paused mismatch');
        assertEq(cfg.frozen, ${c.config.frozen}, 'frozen mismatch');
        assertEq(cfg.borrowable, ${c.config.borrowable}, 'borrowable mismatch');
        assertEq(cfg.receiveSharesEnabled, ${c.config.receiveSharesEnabled}, 'receiveSharesEnabled mismatch');
        ISpoke.DynamicReserveConfig memory dyn = spoke.getDynamicReserveConfig(reserveId, reserve.dynamicConfigKey);
        assertEq(uint256(dyn.collateralFactor), uint256(${c.dynamicConfig.collateralFactor}), 'collateralFactor mismatch');
        assertEq(uint256(dyn.maxLiquidationBonus), uint256(${c.dynamicConfig.maxLiquidationBonus}), 'maxLiquidationBonus mismatch');
        assertEq(uint256(dyn.liquidationFee), uint256(${c.dynamicConfig.liquidationFee}), 'liquidationFee mismatch');
      }`;
    });
    const response: CodeArtifact = {
      code: {
        constants,
        v4Getters: {
          spokeReserveListings: {
            returnType: 'IConfigEngine.ReserveListing',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
