// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IOracleSwapFreezer {
  function ADDRESS_PROVIDER() external view returns (address);
  function GSM() external view returns (address);
  function getCanUnfreeze() external view returns (bool);
  function getFreezeBound() external view returns (uint128, uint128);
  function getUnfreezeBound() external view returns (uint128, uint128);
  function checkUpkeep(bytes calldata) external view returns (bool, bytes memory);
  function performUpkeep(bytes calldata) external;
}
