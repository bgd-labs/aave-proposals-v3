// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBaseAaveAgent {
  function RANGE_VALIDATION_MODULE() external view returns (address);
  function POOL() external view returns (address);
  function AGENT_HUB() external view returns (address);
}
