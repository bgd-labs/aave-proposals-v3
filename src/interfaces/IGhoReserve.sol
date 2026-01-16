// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGhoReserve {
  function addEntity(address entity) external;
  function setLimit(address entity, uint256 limit) external;
  function getLimit(address entity) external view returns (uint256);
  function getUsed(address entity) external view returns (uint256);
  function isEntity(address entity) external view returns (bool);
  function totalEntities() external view returns (uint256);
}
