// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ITypeAndVersion} from './ITypeAndVersion.sol';
interface ITokenAdminRegistry is ITypeAndVersion {
  function owner() external view returns (address);
  function acceptAdminRole(address from) external;
  function proposeAdministrator(address localToken, address administrator) external;
  function transferAdminRole(address localToken, address newAdministrator) external;
  function isAdministrator(address localToken, address administrator) external view returns (bool);
  function getPool(address token) external view returns (address);
  function setPool(address source, address pool) external;
}
