// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IPoolConfigurator, ConfiguratorInputTypes, IACLManager} from 'aave-address-book/AaveV3.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {Ownable} from 'solidity-utils/contracts/oz-common/Ownable.sol';

abstract contract StewardBase is Ownable {
  modifier withRennounceOfAllAavePermissions(IACLManager aclManager) {
    _;

    bytes32[] memory allRoles = getAllAaveRoles();

    for (uint256 i = 0; i < allRoles.length; i++) {
      aclManager.renounceRole(allRoles[i], address(this));
    }
  }

  modifier withOwnershipBurning() {
    _;
    _transferOwnership(address(0));
  }

  function getAllAaveRoles() public pure returns (bytes32[] memory) {
    bytes32[] memory roles = new bytes32[](6);
    roles[0] = 0x19c860a63258efbd0ecb7d55c626237bf5c2044c26c073390b74f0c13c857433; // asset listing
    roles[1] = 0x08fb31c3e81624356c3314088aa971b73bcc82d22bc3e3b184b4593077ae3278; // bridge
    roles[2] = 0x5c91514091af31f62f596a314af7d5be40146b2f2355969392f055e12e0982fb; // emergency admin
    roles[3] = 0x939b8dfb57ecef2aea54a93a15e86768b9d4089f1ba61c245e6ec980695f4ca4; // flash borrower
    roles[4] = 0x12ad05bde78c5ab75238ce885307f96ecd482bb402ef831f99e7018a0f169b7b; // pool admin
    roles[5] = 0x8aa855a911518ecfbe5bc3088c8f3dda7badf130faaf8ace33fdc33828e18167; // risk admin

    return roles;
  }
}
