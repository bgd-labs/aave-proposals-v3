// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IAccessControl} from 'aave-v3-origin/contracts/dependencies/openzeppelin/contracts/IAccessControl.sol';

/**
 * @title Clinic steward activation
 * @author BGD Labs @bgdlabs
 * - Snapshot: will add later
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-clinicsteward/21209
 */
contract ActivationPayload_20250228 is IProposalGenericExecutor {
  address public immutable COLLECTOR;
  address public immutable STEWARD;
  address public immutable CLEANUP_BOT;

  constructor(address collector, address steward, address cleanupBot) {
    COLLECTOR = collector;
    STEWARD = steward;
    CLEANUP_BOT = cleanupBot;
  }

  function execute() external {
    // 1. give steward funds admin
    // IAccessControl(COLLECTOR) ...
    // 2. give bot CLEANUP_ROLE
    // IAccessControl.grantRole ...
  }
}
