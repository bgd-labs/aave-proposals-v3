// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IProofOfReserveExecutor {
  function areAllReservesBacked() external view returns (bool);

  function isEmergencyActionPossible() external view returns (bool);

  function executeEmergencyAction() external;
}
