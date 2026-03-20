// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAccessManager {
  function grantRole(uint64 roleId, address account, uint32 executionDelay) external;
  function getRoleAdmin(uint64 roleId) external view returns (uint64);
  function hasRole(
    uint64 roleId,
    address account
  ) external view returns (bool isMember, uint32 executionDelay);
  function getTargetFunctionRole(address target, bytes4 selector) external view returns (uint64);
}
