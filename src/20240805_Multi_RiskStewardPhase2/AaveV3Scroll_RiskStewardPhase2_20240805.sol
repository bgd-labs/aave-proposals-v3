// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';

/**
 * @title Risk Steward Phase 2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204
 */
contract AaveV3Scroll_RiskStewardPhase2_20240805 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x5E27B8EfDe76814795a07c8a378FcdF09715850b;

  function execute() external {
    AaveV3Scroll.ACL_MANAGER.removeRiskAdmin(AaveV3Scroll.CAPS_PLUS_RISK_STEWARD);
    AaveV3Scroll.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
