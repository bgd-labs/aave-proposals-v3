// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAccessManager {
  function grantRole(uint64 roleId, address account, uint32 executionDelay) external;
  function hasRole(uint64 roleId, address account) external view returns (bool, uint32);
}
