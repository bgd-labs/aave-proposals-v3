import {input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule} from '../../../types';
import {V4RoleMembership} from '../../types';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {buildAddressConstant, sanitizeIdentifier} from '../constants';

export const accessManagerRoleMembership: FeatureModule<V4RoleMembership[]> = {
  value: FEATURE.V4_AM_ROLE_MEMBERSHIP,
  description: 'AccessManager: grant or revoke a role',
  async cli() {
    const response: V4RoleMembership[] = [];
    let more = true;
    while (more) {
      const granted = await confirm({message: 'Grant the role? (no = revoke)', default: true});
      const roleId = await input({
        message: 'Role ID (uint64). Hint: AccessManagerRoles library accessor.',
      });
      const account = await addressPrompt({message: 'Account address', required: true});
      const executionDelay = granted
        ? await input({message: 'Execution delay (seconds, uint32)', default: '0'})
        : '0';
      response.push({
        roleId,
        account: account as `0x${string}`,
        granted,
        executionDelay,
      });
      more = await confirm({message: 'Add another?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const constants: string[] = [];
    const entries = cfg.map((c, ix) => {
      const accountName = `ROLE_${sanitizeIdentifier(c.roleId)}_ACCOUNT_${ix}`;
      constants.push(buildAddressConstant(market, accountName, c.account));
      return `items[__INDEX__] = IConfigEngine.RoleMembership({
        authority: address(${market}.ACCESS_MANAGER),
        roleId: ${c.roleId},
        account: ${accountName},
        granted: ${c.granted},
        executionDelay: ${c.executionDelay}
      });`;
    });
    const testFns = cfg.map((c, ix) => {
      const accountName = `ROLE_${sanitizeIdentifier(c.roleId)}_ACCOUNT_${ix}`;
      const fnSuffix = `${sanitizeIdentifier(c.roleId)}_${ix}`;
      const memberCheck = c.granted
        ? `assertTrue(isMember, 'account should have role');
        assertEq(uint256(executionDelay), uint256(${c.executionDelay}), 'executionDelay mismatch');`
        : `assertFalse(isMember, 'account should not have role');`;
      return `function test_accessManagerRoleMembership_${fnSuffix}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        (bool isMember, uint32 executionDelay) = IAccessManager(address(${market}.ACCESS_MANAGER)).hasRole(
          uint64(${c.roleId}),
          proposal.${accountName}()
        );
        ${memberCheck}
      }`;
    });
    const response: CodeArtifact = {
      code: {
        constants,
        v4Getters: {
          accessManagerRoleMemberships: {
            returnType: 'IConfigEngine.RoleMembership',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
