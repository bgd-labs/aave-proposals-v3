// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGsmRegistry {
  function addGsm(address gsmAddress) external;

  function removeGsm(address gsmAddress) external;
}
