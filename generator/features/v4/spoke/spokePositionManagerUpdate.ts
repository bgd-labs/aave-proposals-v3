import {checkbox, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4SpokePositionManagerUpdate} from '../../types';
import {positionManagerKeys, positionManagerLibAccessor} from '../marketBook';
import {selectSpoke} from '../hubSpokeSelect';
import {accessorIdentifier, shortKey, testAddressRef, wrapAddress} from '../testHelpers';

export const spokePositionManagerUpdate: FeatureModule<V4SpokePositionManagerUpdate[]> = {
  value: FEATURE.V4_SPOKE_POSITION_MANAGER_UPDATE,
  description: 'Spoke: activate/deactivate PositionManagers',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4SpokePositionManagerUpdate[] = [];
    let more = true;
    while (more) {
      const spoke = await selectSpoke(m);
      const pms = await checkbox({
        message: 'Select PositionManagers',
        choices: positionManagerKeys(m).map((k) => ({name: k, value: k})),
        required: true,
      });
      const active = await confirm({message: 'Active?', default: true});
      for (const pm of pms) {
        response.push({
          spokeLib: spoke.expr,
          spoke: spoke.expr,
          positionManager: positionManagerLibAccessor(m, pm) as `0x${string}`,
          active,
        });
      }
      more = await confirm({message: 'Configure another spoke?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.PositionManagerUpdate({
        spokeConfigurator: ${market}.SPOKE_CONFIGURATOR,
        spoke: ${wrapAddress(c.spoke)},
        positionManager: ${wrapAddress(c.positionManager)},
        active: ${c.active}
      });`,
    );
    const inputAsserts = cfg.flatMap((c, ix) => [
      `assertEq(items[${ix}].spoke, ${testAddressRef(c.spoke)}, 'spoke');`,
      `assertEq(items[${ix}].positionManager, ${wrapAddress(c.positionManager)}, 'positionManager');`,
      `assertEq(items[${ix}].active, ${c.active}, 'active');`,
    ]);
    const inputTest = `function test_spokePositionManagerUpdatesInput() public view {
        IConfigEngine.PositionManagerUpdate[] memory items = proposal.spokePositionManagerUpdates();
        assertEq(items.length, ${cfg.length}, 'length');
        ${inputAsserts.join('\n        ')}
      }`;
    const testFns = cfg.map((c, ix) => {
      const spokeKey = accessorIdentifier(c.spoke);
      const pmKey = shortKey(c.positionManager);
      return `function test_spokePositionManagerUpdate_${spokeKey}_${pmKey}_${ix}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        assertEq(
          ISpoke(${testAddressRef(c.spoke)}).isPositionManagerActive(${wrapAddress(c.positionManager)}),
          ${c.active},
          'positionManager active mismatch'
        );
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          spokePositionManagerUpdates: {
            returnType: 'IConfigEngine.PositionManagerUpdate',
            entries,
          },
        },
      },
      test: {fn: [inputTest, ...testFns]},
    };
    return response;
  },
};
