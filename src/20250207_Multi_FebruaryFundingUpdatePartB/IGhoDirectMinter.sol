// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

interface IGhoDirectMinter {
  function mintAndSupply(uint256 amount) external;
  function withdrawAndBurn(uint256 amount) external;
}
