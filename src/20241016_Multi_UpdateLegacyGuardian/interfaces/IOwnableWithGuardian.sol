// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
interface IOwnableWithGuardian {
  function guardian() external view returns (address);
  function updateGuardian(address protocolGuardian) external;
}
