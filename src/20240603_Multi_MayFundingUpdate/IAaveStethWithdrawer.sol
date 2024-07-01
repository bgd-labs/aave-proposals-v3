// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAaveStethWithdrawer {
  function startWithdraw(uint256 amount) external;

  function finalizeWithdraw() external;
}
