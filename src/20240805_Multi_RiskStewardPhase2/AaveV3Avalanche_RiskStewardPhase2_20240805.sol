// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

/**
 * @title Risk Steward Phase 2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204
 */
contract AaveV3Avalanche_RiskStewardPhase2_20240805 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x5d7e9a32E0c3db609089186bEBC4B9d8Eb86ad2c;

  function execute() external {
    AaveV3Avalanche.ACL_MANAGER.removeRiskAdmin(AaveV3Avalanche.CAPS_PLUS_RISK_STEWARD);
    AaveV3Avalanche.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
