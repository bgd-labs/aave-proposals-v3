// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IAccessControl.sol';

interface IGsm is IAccessControl {
  function CONFIGURATOR_ROLE() external pure returns (bytes32);
}
