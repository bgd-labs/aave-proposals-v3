// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

/**
 * @title Risk Steward Phase 2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204
 */
contract AaveV3Polygon_RiskStewardPhase2_20240805 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xfF33BEcB9ECFE4328D4f9C37bE0F07b2CFe976E3;

  function execute() external {
    AaveV3Polygon.ACL_MANAGER.removeRiskAdmin(AaveV3Polygon.CAPS_PLUS_RISK_STEWARD);
    AaveV3Polygon.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
