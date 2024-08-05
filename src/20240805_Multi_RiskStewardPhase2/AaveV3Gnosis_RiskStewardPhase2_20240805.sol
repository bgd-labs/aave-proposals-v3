// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

/**
 * @title Risk Steward Phase 2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204
 */
contract AaveV3Gnosis_RiskStewardPhase2_20240805 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x0b9cA640284cf2636577703f785D5aEEc466BC56;

  function execute() external {
    AaveV3Gnosis.ACL_MANAGER.removeRiskAdmin(AaveV3Gnosis.CAPS_PLUS_RISK_STEWARD);
    AaveV3Gnosis.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
