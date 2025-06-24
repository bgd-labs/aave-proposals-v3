// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Sonic} from 'aave-address-book/AaveV3Sonic.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3Sonic_PendlePTDiscountRateRiskOracleActivation_20250606 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xdb93e2712a8B36835078f8D28c70fCC95FD6d37c;

  function execute() external {
    AaveV3Sonic.ACL_MANAGER.removeRiskAdmin(AaveV3Sonic.RISK_STEWARD);
    AaveV3Sonic.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
