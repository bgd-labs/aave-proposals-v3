import {select, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4SpokePositionManagerUpdate} from '../../types';
import {positionManagerKeys, positionManagerLibAccessor} from '../marketBook';
import {selectSpoke} from '../hubSpokeSelect';
import {accessorIdentifier, shortKey} from '../testHelpers';

export const spokePositionManagerUpdate: FeatureModule<V4SpokePositionManagerUpdate[]> = {
  value: FEATURE.V4_SPOKE_POSITION_MANAGER_UPDATE,
  description: 'Spoke: activate/deactivate a PositionManager',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4SpokePositionManagerUpdate[] = [];
    let more = true;
    while (more) {
      const pm = await select({
        message: 'Select PositionManager',
        choices: positionManagerKeys(m).map((k) => ({name: k, value: k})),
      });
      const spoke = await selectSpoke(m);
      const active = await confirm({message: 'Active?', default: true});
      response.push({
        spokeLib: spoke.expr,
        spoke: spoke.expr,
        positionManager: positionManagerLibAccessor(m, pm) as `0x${string}`,
        active,
      });
      more = await confirm({message: 'Add another?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.PositionManagerUpdate({
        spokeConfigurator: ${market}.SPOKE_CONFIGURATOR,
        spoke: address(${c.spoke}),
        positionManager: address(${c.positionManager}),
        active: ${c.active}
      });`,
    );
    const testFns = cfg.map((c, ix) => {
      const spokeKey = accessorIdentifier(c.spoke);
      const pmKey = shortKey(c.positionManager);
      return `function test_spokePositionManagerUpdate_${spokeKey}_${pmKey}_${ix}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        assertEq(
          ISpoke(address(${c.spoke})).isPositionManagerActive(address(${c.positionManager})),
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
      test: {fn: testFns},
    };
    return response;
  },
};
