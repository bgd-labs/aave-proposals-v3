import {input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule} from '../../../types';
import {V4TargetFunctionRoleUpdate} from '../../types';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {buildAddressConstant, sanitizeIdentifier} from '../constants';

export const accessManagerTargetFunctionRoleUpdate: FeatureModule<V4TargetFunctionRoleUpdate[]> = {
  value: FEATURE.V4_AM_TARGET_FUNCTION_ROLE_UPDATE,
  description: 'AccessManager: map selectors to a role on a target',
  async cli() {
    const response: V4TargetFunctionRoleUpdate[] = [];
    let more = true;
    while (more) {
      const target = await addressPrompt({message: 'Target contract address', required: true});
      const roleId = await input({message: 'Role ID (uint64)'});
      const selectorsCsv = await input({
        message: 'Selectors (comma-separated, e.g. 0x12345678,0xabcdef00)',
      });
      const selectors = selectorsCsv
        .split(',')
        .map((s) => s.trim())
        .filter(Boolean);
      response.push({
        target: target as `0x${string}`,
        selectors,
        roleId,
      });
      more = await confirm({message: 'Add another?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const constants: string[] = [];
    const entries = cfg.map((c, ix) => {
      let targetExpr: string;
      if (c.target.startsWith('0x')) {
        const targetName = `ROLE_${sanitizeIdentifier(c.roleId)}_TARGET_${ix}`;
        constants.push(buildAddressConstant(market, targetName, c.target));
        targetExpr = targetName;
      } else {
        targetExpr = `address(${c.target})`;
      }
      return `{
        bytes4[] memory selectors = new bytes4[](${c.selectors.length});
        ${c.selectors.map((s, jx) => `selectors[${jx}] = bytes4(${s});`).join('\n')}
        items[__INDEX__] = IConfigEngine.TargetFunctionRoleUpdate({
          authority: address(${market}.ACCESS_MANAGER),
          target: ${targetExpr},
          selectors: selectors,
          roleId: ${c.roleId}
        });
      }`;
    });
    const testFns = cfg.flatMap((c, ix) => {
      const targetIsLib = !c.target.startsWith('0x');
      const targetExpr = targetIsLib
        ? `address(${c.target})`
        : `proposal.ROLE_${sanitizeIdentifier(c.roleId)}_TARGET_${ix}()`;
      return c.selectors.map(
        (s, jx) =>
          `function test_accessManagerTargetFunctionRoleUpdate_${sanitizeIdentifier(c.roleId)}_${ix}_${jx}() public {
            GovV3Helpers.executePayload(vm, address(proposal));
            assertEq(
              uint256(IAccessManager(address(${market}.ACCESS_MANAGER)).getTargetFunctionRole(${targetExpr}, bytes4(${s}))),
              uint256(${c.roleId}),
              'selector role mismatch'
            );
          }`,
      );
    });
    const response: CodeArtifact = {
      code: {
        constants,
        v4Getters: {
          accessManagerTargetFunctionRoleUpdates: {
            returnType: 'IConfigEngine.TargetFunctionRoleUpdate',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
