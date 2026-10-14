// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @dev Stand-in for the Midas access control that grants `roleA` and `roleB` to every account and
/// no other role.
contract MidasAccessControlMock {
  bytes32 internal immutable ROLE_A;
  bytes32 internal immutable ROLE_B;

  constructor(bytes32 roleA, bytes32 roleB) {
    ROLE_A = roleA;
    ROLE_B = roleB;
  }

  function hasRole(bytes32 role, address) external view returns (bool) {
    return role == ROLE_A || role == ROLE_B;
  }
}
