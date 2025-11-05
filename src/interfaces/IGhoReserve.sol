// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGhoReserve {
  function addEntity(address entity) external;
  function setLimit(address entity, uint256 limit) external;
}
