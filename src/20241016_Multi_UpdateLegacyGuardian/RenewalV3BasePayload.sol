// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {IOwnableWithGuardian} from './interfaces/IOwnableWithGuardian.sol';

struct RenewalV3Params {
  IACLManager aclManager;
  address governance;
  address payloadsController;
  address protocolGuardian;
  address governanceGuardian;
  address oldGuardian;
}

contract RenewalV3BasePayload is IProposalGenericExecutor {
  IACLManager public immutable ACL_MANAGER;
  address public immutable GOVERNANCE;
  address public immutable PAYLOADS_CONTROLLER;
  address public immutable PROTOCOL_GUARDIAN;
  address public immutable GOVERNANCE_GUARDIAN;
  address public immutable OLD_GUARDIAN;
  constructor(RenewalV3Params memory params) {
    ACL_MANAGER = params.aclManager;
    GOVERNANCE = params.governance;
    PAYLOADS_CONTROLLER = params.payloadsController;
    PROTOCOL_GUARDIAN = params.protocolGuardian;
    GOVERNANCE_GUARDIAN = params.governanceGuardian;
    OLD_GUARDIAN = params.oldGuardian;
  }
  function execute() external {
    ACL_MANAGER.removeEmergencyAdmin(OLD_GUARDIAN);
    ACL_MANAGER.addEmergencyAdmin(PROTOCOL_GUARDIAN);
    if (GOVERNANCE != address(0)) {
      IOwnableWithGuardian(GOVERNANCE).updateGuardian(GOVERNANCE_GUARDIAN);
    }
    IOwnableWithGuardian(PAYLOADS_CONTROLLER).updateGuardian(GOVERNANCE_GUARDIAN);
  }
}
