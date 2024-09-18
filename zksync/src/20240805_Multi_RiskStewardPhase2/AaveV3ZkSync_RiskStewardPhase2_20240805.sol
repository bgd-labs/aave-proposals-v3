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
  address public constant NEW_RISK_STEWARD = 0xDeDee21f34eff4e2902B95A106855834a608e19a;

  function execute() external {
    AaveV3ZkSync.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
