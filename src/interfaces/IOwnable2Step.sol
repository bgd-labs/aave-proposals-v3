// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IOwnable} from 'aave-address-book/common/IOwnable.sol';

interface IOwnable2Step is IOwnable {
  function pendingOwner() external view returns (address);

  function acceptOwnership() external;
}
