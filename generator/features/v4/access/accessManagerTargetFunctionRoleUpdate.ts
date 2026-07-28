import {input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifier} from '../../../types';
import {V4TargetFunctionRoleUpdate} from '../../types';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {buildAddressConstant, sanitizeIdentifier} from '../constants';
import {accessorIdentifier, wrapAddress} from '../testHelpers';

/// Shared test helper asserting a wiring item landed on the target, and that the wired
/// selectors carry the same role on a reference contract when one is given.
function rolesWiredHelper(market: MarketIdentifier): string {
  const accessManager = `IAccessManager(address(${market}.ACCESS_MANAGER))`;
  return `function _assertRolesWired(
    IConfigEngine.TargetFunctionRoleUpdate memory item,
    address referenceTarget
  ) internal view {
    for (uint256 i; i < item.selectors.length; ++i) {
      uint64 roleId = ${accessManager}.getTargetFunctionRole(item.target, item.selectors[i]);
      assertEq(uint256(roleId), uint256(item.roleId), 'role not wired');
      if (referenceTarget == address(0)) continue;
      assertEq(
        uint256(roleId),
        uint256(${accessManager}.getTargetFunctionRole(referenceTarget, item.selectors[i])),
        'role divergence vs reference target'
      );
    }
  }`;
}

/// Name of the payload constant holding a raw-address target. Derived from the address
/// rather than the config position, so the same target named by two features yields one
/// constant instead of two colliding ones.
function targetConstantName(c: V4TargetFunctionRoleUpdate): string {
  return `ROLE_${sanitizeIdentifier(c.roleId)}_TARGET_${accessorIdentifier(c.target)}`;
}

/// Codegen for a target-function-role update's `target`: a raw address is emitted as
/// a named constant; a codegen expr (accessor or payload constant) is used directly.
function targetCodegen(
  market: MarketIdentifier,
  constants: string[],
  c: V4TargetFunctionRoleUpdate,
): string {
  if (c.target.startsWith('0x')) {
    const targetName = targetConstantName(c);
    constants.push(buildAddressConstant(market, targetName, c.target as `0x${string}`));
    return targetName;
  }
  return wrapAddress(c.target);
}

/// Solidity-identifier-safe key for a target, used in generated test names.
function targetIdentifier(c: V4TargetFunctionRoleUpdate): string {
  if (c.target.startsWith('0x')) return targetConstantName(c);
  return accessorIdentifier(c.target);
}

function targetTestCodegen(c: V4TargetFunctionRoleUpdate): string {
  if (c.target.startsWith('0x')) return `proposal.${targetConstantName(c)}()`;
  if (c.target.includes('.')) return `address(${c.target})`;
  return `proposal.${c.target}()`;
}

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
    const entries = cfg.map((c) => {
      const targetExpr = targetCodegen(market, constants, c);
      if (c.selectorsExpr) {
        return `items[__INDEX__] = IConfigEngine.TargetFunctionRoleUpdate({
          authority: address(${market}.ACCESS_MANAGER),
          target: ${targetExpr},
          selectors: ${c.selectorsExpr},
          roleId: ${c.roleId}
        });`;
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
    const inputAsserts = cfg.map((c) => {
      const lines = [
        `assertEq(items[__INDEX__].authority, address(${market}.ACCESS_MANAGER), 'authority');`,
        `assertEq(items[__INDEX__].target, ${targetTestCodegen(c)}, 'target');`,
        `assertEq(uint256(items[__INDEX__].roleId), uint256(${c.roleId}), 'roleId');`,
      ];
      if (c.selectorAsserts) {
        lines.push(
          `assertEq(items[__INDEX__].selectors.length, ${c.selectorAsserts.length}, 'selectors length');`,
        );
        c.selectorAsserts.forEach((sel, jx) =>
          lines.push(
            `assertEq(uint32(items[__INDEX__].selectors[${jx}]), uint32(${sel}), 'selector ${jx}');`,
          ),
        );
      }
      return lines.join('\n        ');
    });
    // One test per target, matching on the target rather than on a config position:
    // the getter also carries the wiring of every other feature in the payload.
    const byTarget = new Map<string, V4TargetFunctionRoleUpdate>();
    cfg.forEach((c) => byTarget.set(c.target, byTarget.get(c.target) ?? c));
    const testFns = [...byTarget.values()].map((c) => {
      const referenceExpr = c.referenceTarget ? wrapAddress(c.referenceTarget) : 'address(0)';
      return `function test_rolesWired_${targetIdentifier(c)}() public {
        IConfigEngine.TargetFunctionRoleUpdate[] memory items = proposal.accessManagerTargetFunctionRoleUpdates();
        GovV3Helpers.executePayload(vm, address(proposal));
        uint256 matched;
        for (uint256 i; i < items.length; ++i) {
          if (items[i].target != ${targetTestCodegen(c)}) continue;
          _assertRolesWired(items[i], ${referenceExpr});
          ++matched;
        }
        assertGt(matched, 0, 'no wiring for target');
      }`;
    });
    const response: CodeArtifact = {
      code: {
        constants,
        v4Getters: {
          accessManagerTargetFunctionRoleUpdates: {
            returnType: 'IConfigEngine.TargetFunctionRoleUpdate',
            entries,
            inputAsserts,
          },
        },
      },
      test: {fn: testFns, helpers: [rolesWiredHelper(market)]},
    };
    return response;
  },
};
