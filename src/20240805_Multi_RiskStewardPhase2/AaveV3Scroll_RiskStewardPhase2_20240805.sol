// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';

/**
 * @title Risk Steward Phase 2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4809f179e517e5745ec13eba8f40d98dab73ca65f8a141bd2f18cc16dcd0cc16
 * - Discussion: https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204
 */
contract AaveV3Scroll_RiskStewardPhase2_20240805 is IProposalGenericExecutor {
  function execute() external {
    AaveV3Scroll.ACL_MANAGER.addRiskAdmin(AaveV3Scroll.RISK_STEWARD);
  }
}
