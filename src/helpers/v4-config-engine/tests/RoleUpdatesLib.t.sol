// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';

import {RoleUpdatesLib} from '../RoleUpdatesLib.sol';

/**
 * @dev command: forge test --match-path=src/helpers/v4-config-engine/tests/RoleUpdatesLib.t.sol -vv
 */
contract RoleUpdatesLibTest is Test {
  function test_merge_concatenatesPreservingOrder() public view {
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory a = _updates(2);
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory b = _updates(3);

    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory merged = RoleUpdatesLib.merge(a, b);

    assertEq(merged.length, 5, 'merged length must be the sum of operands');
    // `a` entries come first, in order, then `b` entries.
    assertEq(merged[0].target, a[0].target);
    assertEq(uint256(merged[0].roleId), uint256(a[0].roleId));
    assertEq(merged[1].target, a[1].target);
    assertEq(merged[2].target, b[0].target);
    assertEq(merged[3].target, b[1].target);
    assertEq(merged[4].target, b[2].target);
    assertEq(uint256(merged[4].roleId), uint256(b[2].roleId));
  }

  function test_merge_handlesEmptyOperands() public view {
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory empty = _updates(0);
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory one = _updates(1);

    assertEq(RoleUpdatesLib.merge(empty, empty).length, 0);

    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory leftEmpty = RoleUpdatesLib.merge(
      empty,
      one
    );
    assertEq(leftEmpty.length, 1);
    assertEq(leftEmpty[0].target, one[0].target);

    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory rightEmpty = RoleUpdatesLib.merge(
      one,
      empty
    );
    assertEq(rightEmpty.length, 1);
    assertEq(rightEmpty[0].target, one[0].target);
  }

  function _updates(
    uint256 count
  ) internal view returns (IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory) {
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[]
      memory updates = new IAaveV4ConfigEngine.TargetFunctionRoleUpdate[](count);
    for (uint256 i; i < count; ++i) {
      updates[i] = IAaveV4ConfigEngine.TargetFunctionRoleUpdate({
        authority: vm.randomAddress(),
        target: vm.randomAddress(),
        selectors: new bytes4[](0),
        roleId: uint64(vm.randomUint())
      });
    }
    return updates;
  }
}
