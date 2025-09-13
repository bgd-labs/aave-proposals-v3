// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'aave-v3-origin/contracts/dependencies/openzeppelin/contracts/IAccessControl.sol';
import {ICollector} from 'aave-v3-origin/contracts/treasury/Collector.sol';

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Aave V2 deprecation
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-aave-v2-deprecation-tech-next-phase/23022
 */
contract ClinicStewardV2Activation_20250904 is IProposalGenericExecutor {
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
    IAccessControl(COLLECTOR).grantRole(ICollector(COLLECTOR).FUNDS_ADMIN_ROLE(), STEWARD);
    // 2. give bot CLEANUP_ROLE
    IAccessControl(STEWARD).grantRole(keccak256('CLEANUP_ROLE'), CLEANUP_BOT);
  }
}
