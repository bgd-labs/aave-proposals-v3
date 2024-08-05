// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

/**
 * @title Risk Steward Phase 2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/arfc-bgd-risk-steward-phase-2-risksteward/16204
 */
contract AaveV3EthereumLido_RiskStewardPhase2_20240805 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x45C4f8b32927eFFdf1dA3cA42498504947dd4d0D;

  function execute() external {
    AaveV3EthereumLido.ACL_MANAGER.removeRiskAdmin(AaveV3EthereumLido.CAPS_PLUS_RISK_STEWARD);
    AaveV3EthereumLido.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
