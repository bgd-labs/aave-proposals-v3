// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

/**
 * @title Risk Steward Phase 2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204
 */
contract AaveV3Arbitrum_RiskStewardPhase2_20240805 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x9EEa1Ba822d204077e9f90a92D30432417184587;

  function execute() external {
    AaveV3Arbitrum.ACL_MANAGER.removeRiskAdmin(AaveV3Arbitrum.CAPS_PLUS_RISK_STEWARD);
    AaveV3Arbitrum.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
