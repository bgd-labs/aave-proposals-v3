// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IGuardianEnabledFlag} from 'src/interfaces/IGuardianEnabledFlag.sol';

contract GuardianEnabledFlag is IGuardianEnabledFlag {
  address public immutable GUARDIAN;
  bool public enabled;

  modifier onlyGuardian() {
    require(msg.sender == GUARDIAN, 'Only guardian');
    _;
  }

  constructor(address guardian) {
    require(guardian != address(0), 'ZERO_GUARDIAN');
    GUARDIAN = guardian;
  }

  function setEnabled(bool newEnabled) external onlyGuardian {
    enabled = newEnabled;
    emit SetEnabled(msg.sender, newEnabled);
  }
}
