// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

/**
 * @title Risk Steward Phase 2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204
 */
contract AaveV3Optimism_RiskStewardPhase2_20240805 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x9062F78b631f33D24Ed058cBc116A653452ea82A;

  function execute() external {
    AaveV3Optimism.ACL_MANAGER.removeRiskAdmin(AaveV3Optimism.CAPS_PLUS_RISK_STEWARD);
    AaveV3Optimism.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
