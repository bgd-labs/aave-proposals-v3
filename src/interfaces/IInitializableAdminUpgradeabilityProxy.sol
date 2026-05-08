// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.0;

interface IInitializableAdminUpgradeabilityProxy {
  function upgradeToAndCall(address newImplementation, bytes calldata data) external payable;
  function admin() external returns (address);
  function REVISION() external returns (uint256);
  function changeAdmin(address newAdmin) external;
}
