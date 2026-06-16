import {select, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4PMRoleRenouncement} from '../../types';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {
  positionManagerKeys,
  positionManagerLibAccessor,
  spokeKeys,
  spokeLibAccessor,
} from '../marketBook';
import {shortKey} from '../testHelpers';
import {buildAddressConstant} from '../constants';

export const positionManagerRoleRenouncement: FeatureModule<V4PMRoleRenouncement[]> = {
  value: FEATURE.V4_PM_ROLE_RENOUNCEMENT,
  description: 'PositionManager: renounce a role',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4PMRoleRenouncement[] = [];
    let more = true;
    while (more) {
      const pm = await select({
        message: 'Select PositionManager',
        choices: positionManagerKeys(m).map((k) => ({name: k, value: k})),
      });
      const spoke = await select({
        message: 'Select spoke',
        choices: spokeKeys(m).map((k) => ({name: k, value: k})),
      });
      const user = await addressPrompt({message: 'User to renounce role for', required: true});
      response.push({
        positionManager: positionManagerLibAccessor(m, pm) as `0x${string}`,
        spoke: spokeLibAccessor(m, spoke),
        user: user as `0x${string}`,
      });
      more = await confirm({message: 'Add another?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const constants: string[] = [];
    const entries = cfg.map((c, ix) => {
      const userName = `PM_ROLE_RENOUNCE_USER_${ix}`;
      constants.push(buildAddressConstant(market, userName, c.user));
      return `items[__INDEX__] = IConfigEngine.PositionManagerRoleRenouncement({
        positionManager: address(${c.positionManager}),
        spoke: address(${c.spoke}),
        user: ${userName}
      });`;
    });
    const testFns = cfg.map((c, ix) => {
      const pmKey = shortKey(c.positionManager);
      const spokeKey = shortKey(c.spoke);
      const userName = `PM_ROLE_RENOUNCE_USER_${ix}`;
      return `function test_positionManagerRoleRenouncement_${pmKey}_${spokeKey}_${ix}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        assertFalse(
          ISpoke(address(${c.spoke})).isPositionManager(proposal.${userName}(), address(${c.positionManager})),
          'role not renounced'
        );
      }`;
    });
    const response: CodeArtifact = {
      code: {
        constants,
        v4Getters: {
          positionManagerRoleRenouncements: {
            returnType: 'IConfigEngine.PositionManagerRoleRenouncement',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
