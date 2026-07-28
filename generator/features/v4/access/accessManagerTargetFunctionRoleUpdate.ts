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

/// Codegen for a target-function-role update's `target`: a raw address is emitted as
/// a named constant; a codegen expr (accessor or payload constant) is used directly.
function targetCodegen(
  market: MarketIdentifier,
  constants: string[],
  c: V4TargetFunctionRoleUpdate,
  ix: number,
): string {
  if (c.target.startsWith('0x')) {
    const targetName = `ROLE_${sanitizeIdentifier(c.roleId)}_TARGET_${ix}`;
    constants.push(buildAddressConstant(market, targetName, c.target as `0x${string}`));
    return targetName;
  }
  return wrapAddress(c.target);
}

/// Solidity-identifier-safe key for a target, used in generated test names.
function targetIdentifier(c: V4TargetFunctionRoleUpdate, ix: number): string {
  if (c.target.startsWith('0x')) return `ROLE_${sanitizeIdentifier(c.roleId)}_TARGET_${ix}`;
  return accessorIdentifier(c.target);
}

function targetTestCodegen(c: V4TargetFunctionRoleUpdate, ix: number): string {
  if (c.target.startsWith('0x'))
    return `proposal.ROLE_${sanitizeIdentifier(c.roleId)}_TARGET_${ix}()`;
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
    const entries = cfg.map((c, ix) => {
      const targetExpr = targetCodegen(market, constants, c, ix);
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
    const inputAsserts = cfg.flatMap((c, ix) => {
      const lines = [
        `assertEq(items[${ix}].authority, address(${market}.ACCESS_MANAGER), 'authority');`,
        `assertEq(items[${ix}].target, ${targetTestCodegen(c, ix)}, 'target');`,
        `assertEq(uint256(items[${ix}].roleId), uint256(${c.roleId}), 'roleId');`,
      ];
      if (c.selectorAsserts) {
        lines.push(
          `assertEq(items[${ix}].selectors.length, ${c.selectorAsserts.length}, 'selectors length');`,
        );
        c.selectorAsserts.forEach((sel, jx) =>
          lines.push(
            `assertEq(uint32(items[${ix}].selectors[${jx}]), uint32(${sel}), 'selector ${jx}');`,
          ),
        );
      }
      return lines;
    });
    const inputTest = `function test_accessManagerTargetFunctionRoleUpdatesInput() public view {
        IConfigEngine.TargetFunctionRoleUpdate[] memory items = proposal.accessManagerTargetFunctionRoleUpdates();
        assertEq(items.length, ${cfg.length}, 'length');
        ${inputAsserts.join('\n        ')}
      }`;
    // One test per target: every role wired on the same contract is asserted together.
    const byTarget = new Map<string, number[]>();
    cfg.forEach((c, ix) => byTarget.set(c.target, [...(byTarget.get(c.target) ?? []), ix]));
    const testFns = [...byTarget].map(([, ixs]) => {
      const reference = cfg[ixs[0]].referenceTarget;
      const referenceExpr = reference ? wrapAddress(reference) : 'address(0)';
      const asserts = ixs.map((ix) => `_assertRolesWired(items[${ix}], ${referenceExpr});`);
      return `function test_rolesWired_${targetIdentifier(cfg[ixs[0]], ixs[0])}() public {
        IConfigEngine.TargetFunctionRoleUpdate[] memory items = proposal.accessManagerTargetFunctionRoleUpdates();
        GovV3Helpers.executePayload(vm, address(proposal));
        ${asserts.join('\n        ')}
      }`;
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
      test: {fn: [inputTest, ...testFns], helpers: [rolesWiredHelper(market)]},
    };
    return response;
  },
};
