// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';

/**
 * @title Risk Steward Phase 2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204
 */
contract AaveV3BNB_RiskStewardPhase2_20240805 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x45918bB1D3F73904a30Ffc3eD11CdB1c05eBF726;

  function execute() external {
    AaveV3BNB.ACL_MANAGER.removeRiskAdmin(AaveV3BNB.CAPS_PLUS_RISK_STEWARD);
    AaveV3BNB.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
