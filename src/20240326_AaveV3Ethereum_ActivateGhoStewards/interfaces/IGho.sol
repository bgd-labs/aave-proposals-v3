// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IAccessControl.sol';

interface IGhoToken is IAccessControl {
  function BUCKET_MANAGER_ROLE() external pure returns (bytes32);

  function getFacilitatorsList() external view returns (address[] memory);

  function getFacilitatorBucket(address facilitator) external view returns (uint256, uint256);
}
