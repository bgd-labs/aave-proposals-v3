// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';

/// @title RoleUpdatesLib
/// @notice Utilities for composing AccessManager target-function-role updates consumed by the V4
///         config engine.
library RoleUpdatesLib {
  function merge(
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory a,
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory b
  ) internal pure returns (IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory) {
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[]
      memory merged = new IAaveV4ConfigEngine.TargetFunctionRoleUpdate[](a.length + b.length);
    uint256 index;
    for (uint256 i; i < a.length; ++i) merged[index++] = a[i];
    for (uint256 i; i < b.length; ++i) merged[index++] = b[i];
    return merged;
  }
}
