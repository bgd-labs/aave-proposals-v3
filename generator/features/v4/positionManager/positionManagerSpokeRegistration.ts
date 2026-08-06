import {select, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4PMSpokeRegistration} from '../../types';
import {positionManagerKeys, positionManagerLibAccessor} from '../marketBook';
import {selectSpokes} from '../hubSpokeSelect';
import {accessorIdentifier, shortKey} from '../testHelpers';

export const positionManagerSpokeRegistration: FeatureModule<V4PMSpokeRegistration[]> = {
  value: FEATURE.V4_PM_SPOKE_REGISTRATION,
  description: 'PositionManager: register or deregister a Spoke',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4PMSpokeRegistration[] = [];
    const pm = await select({
      message: 'Select PositionManager',
      choices: positionManagerKeys(m).map((k) => ({name: k, value: k})),
    });
    const spokes = await selectSpokes(m, {message: 'Select spokes'});
    const registered = await confirm({message: 'Register? (no = deregister)', default: true});
    for (const spoke of spokes) {
      response.push({
        positionManager: positionManagerLibAccessor(m, pm) as `0x${string}`,
        spoke: spoke.expr,
        registered,
      });
    }
    return response;
  },
  build({cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.SpokeRegistration({
        positionManager: address(${c.positionManager}),
        spoke: address(${c.spoke}),
        registered: ${c.registered}
      });`,
    );
    const testFns = cfg.map((c, ix) => {
      const pmKey = shortKey(c.positionManager);
      const spokeKey = accessorIdentifier(c.spoke);
      return `function test_positionManagerSpokeRegistration_${pmKey}_${spokeKey}_${ix}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        assertEq(
          IPositionManagerBase(address(${c.positionManager})).isSpokeRegistered(address(${c.spoke})),
          ${c.registered},
          'spoke registration mismatch'
        );
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          positionManagerSpokeRegistrations: {
            returnType: 'IConfigEngine.SpokeRegistration',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
