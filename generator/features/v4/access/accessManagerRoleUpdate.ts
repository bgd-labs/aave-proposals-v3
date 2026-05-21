import {input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule} from '../../../types';
import {V4RoleUpdate} from '../../types';
import {keepCurrentUint64, keepCurrentUint32, literal, renderSentinel} from '../sentinels';
import {Sentinel} from '../../types';
import {isLiteral, literalValue} from '../testHelpers';
import {sanitizeIdentifier} from '../constants';

async function uint64SentinelPrompt(message: string): Promise<Sentinel> {
  const v = await input({message: `${message} (empty = keep current)`});
  if (!v) return keepCurrentUint64();
  return literal(v);
}

async function uint32SentinelPrompt(message: string): Promise<Sentinel> {
  const v = await input({message: `${message} (empty = keep current)`});
  if (!v) return keepCurrentUint32();
  return literal(v);
}

export const accessManagerRoleUpdate: FeatureModule<V4RoleUpdate[]> = {
  value: FEATURE.V4_AM_ROLE_UPDATE,
  description: 'AccessManager: update role admin, guardian, grant delay, and/or label',
  async cli() {
    const response: V4RoleUpdate[] = [];
    let more = true;
    while (more) {
      const roleId = await input({message: 'Role ID (uint64)'});
      const admin = await uint64SentinelPrompt('New admin role (uint64)');
      const guardian = await uint64SentinelPrompt('New guardian role (uint64)');
      const grantDelay = await uint32SentinelPrompt('New grant delay (uint32, seconds)');
      const label = await input({message: 'New label (empty = keep current)'});
      response.push({
        authority: 'AaveV4Ethereum.ACCESS_MANAGER',
        roleId,
        admin,
        guardian,
        grantDelay,
        label,
      });
      more = await confirm({message: 'Add another?', default: false});
    }
    return response;
  },
  build({cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IAaveV4ConfigEngine.RoleUpdate({
        authority: address(${c.authority}),
        roleId: ${c.roleId},
        admin: ${renderSentinel(c.admin)},
        guardian: ${renderSentinel(c.guardian)},
        grantDelay: ${renderSentinel(c.grantDelay)},
        label: '${c.label.replace(/'/g, "\\'")}'
      });`,
    );
    const testFns = cfg.map((c, ix) => {
      const fnSuffix = `${sanitizeIdentifier(c.roleId)}_${ix}`;
      const asserts: string[] = [];
      if (isLiteral(c.admin)) {
        asserts.push(
          `assertEq(uint256(IAccessManager(address(${c.authority})).getRoleAdmin(uint64(${c.roleId}))), uint256(${literalValue(c.admin)}), 'admin mismatch');`,
        );
      }
      if (isLiteral(c.guardian)) {
        asserts.push(
          `assertEq(uint256(IAccessManager(address(${c.authority})).getRoleGuardian(uint64(${c.roleId}))), uint256(${literalValue(c.guardian)}), 'guardian mismatch');`,
        );
      }
      if (isLiteral(c.grantDelay)) {
        asserts.push(
          `assertEq(uint256(IAccessManager(address(${c.authority})).getRoleGrantDelay(uint64(${c.roleId}))), uint256(${literalValue(c.grantDelay)}), 'grantDelay mismatch');`,
        );
      }
      return `function test_accessManagerRoleUpdate_${fnSuffix}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        ${asserts.join('\n        ')}
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          accessManagerRoleUpdates: {
            returnType: 'IAaveV4ConfigEngine.RoleUpdate',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
