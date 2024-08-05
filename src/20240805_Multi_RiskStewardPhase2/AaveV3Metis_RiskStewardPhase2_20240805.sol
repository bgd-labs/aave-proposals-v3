// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';

/**
 * @title Risk Steward Phase 2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204
 */
contract AaveV3Metis_RiskStewardPhase2_20240805 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xF73F2634b43344d86921DA3391d4EF0d5675Dd63;

  function execute() external {
    AaveV3Metis.ACL_MANAGER.removeRiskAdmin(AaveV3Metis.CAPS_PLUS_RISK_STEWARD);
    AaveV3Metis.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
