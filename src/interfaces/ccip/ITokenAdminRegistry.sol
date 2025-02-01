// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITokenAdminRegistry {
  struct TokenConfig {
    address administrator;
    address pendingAdministrator;
    address tokenPool;
  }

  error AlreadyRegistered(address token);
  error InvalidTokenPoolToken(address token);
  error OnlyAdministrator(address sender, address token);
  error OnlyPendingAdministrator(address sender, address token);
  error OnlyRegistryModuleOrOwner(address sender);
  error ZeroAddress();

  event AdministratorTransferRequested(
    address indexed token,
    address indexed currentAdmin,
    address indexed newAdmin
  );
  event AdministratorTransferred(address indexed token, address indexed newAdmin);
  event OwnershipTransferRequested(address indexed from, address indexed to);
  event OwnershipTransferred(address indexed from, address indexed to);
  event PoolSet(address indexed token, address indexed previousPool, address indexed newPool);
  event RegistryModuleAdded(address module);
  event RegistryModuleRemoved(address indexed module);

  function acceptAdminRole(address localToken) external;
  function acceptOwnership() external;
  function addRegistryModule(address module) external;
  function getAllConfiguredTokens(
    uint64 startIndex,
    uint64 maxCount
  ) external view returns (address[] memory tokens);
  function getPool(address token) external view returns (address);
  function getPools(address[] memory tokens) external view returns (address[] memory);
  function getTokenConfig(address token) external view returns (TokenConfig memory);
  function isAdministrator(address localToken, address administrator) external view returns (bool);
  function isRegistryModule(address module) external view returns (bool);
  function owner() external view returns (address);
  function proposeAdministrator(address localToken, address administrator) external;
  function removeRegistryModule(address module) external;
  function setPool(address localToken, address pool) external;
  function transferAdminRole(address localToken, address newAdmin) external;
  function transferOwnership(address to) external;
  function typeAndVersion() external view returns (string memory);
}
