// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IUmbrella as IAddressBookUmbrella} from 'aave-address-book/common/IUmbrella.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';

interface IUmbrella is IAddressBookUmbrella, IAccessControl {
  function PAUSE_GUARDIAN_ROLE() external view returns (bytes32);
}
