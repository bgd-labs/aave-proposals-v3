// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {IOwnableWithGuardian} from './interfaces/IOwnableWithGuardian.sol';

struct RenewalV3Params {
  IACLManager aclManager;
  address governance;
  address payloadsController;
  address newGuardian;
  address oldGuardian;
}

contract RenewalV3BasePayload is IProposalGenericExecutor {
  IACLManager public immutable ACL_MANAGER;
  address public immutable GOVERNANCE;
  address public immutable PAYLOADS_CONTROLLER;
  address public immutable NEW_GUARDIAN;
  address public immutable OLD_GUARDIAN;

  constructor(RenewalV3Params memory params) {
    ACL_MANAGER = params.aclManager;
    GOVERNANCE = params.governance;
    PAYLOADS_CONTROLLER = params.payloadsController;
    NEW_GUARDIAN = params.newGuardian;
    OLD_GUARDIAN = params.oldGuardian;
  }

  function execute() external {
    ACL_MANAGER.removeEmergencyAdmin(OLD_GUARDIAN);
    ACL_MANAGER.addEmergencyAdmin(NEW_GUARDIAN);

    if (GOVERNANCE != address(0)) {
      IOwnableWithGuardian(GOVERNANCE).updateGuardian(NEW_GUARDIAN);
    }

    IOwnableWithGuardian(PAYLOADS_CONTROLLER).updateGuardian(NEW_GUARDIAN);
  }
}
