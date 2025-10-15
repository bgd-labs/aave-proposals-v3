// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IClinicSteward {
  function availableBudget() external view returns (uint256);

  function setAvailableBudget(uint256 newAvailableBudget) external;
}
