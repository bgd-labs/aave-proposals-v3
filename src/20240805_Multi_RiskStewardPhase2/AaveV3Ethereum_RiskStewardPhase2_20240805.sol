// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Risk Steward Phase 2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204
 */
contract AaveV3Ethereum_RiskStewardPhase2_20240805 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xF3911922bd054Bf6f4d6A02B8ADAC444921B0c51;

  function execute() external {
    AaveV3Ethereum.ACL_MANAGER.removeRiskAdmin(AaveV3Ethereum.CAPS_PLUS_RISK_STEWARD);
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
