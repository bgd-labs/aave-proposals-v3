// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAaveStewardInjector {
  function getMarkets() external view returns (address[] memory);

  function removeMarkets(address[] calldata markets) external;

  function getUpdateTypes() external pure returns (string[] memory updateTypes);

  function RISK_STEWARD() external view returns (address);

  function RISK_ORACLE() external view returns (address);
}
