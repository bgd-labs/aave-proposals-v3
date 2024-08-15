// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

/**
 * @title Risk Steward Phase 2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204
 */
contract AaveV3ZkSync_RiskStewardPhase2_20240805 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xBDa9FF2b03D4c3E7014743674c29eD1b3c230dEf;

  function execute() external {
    AaveV3ZkSync.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
