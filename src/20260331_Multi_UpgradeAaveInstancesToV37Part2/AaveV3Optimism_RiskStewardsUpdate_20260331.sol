// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Optimism
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Optimism_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x33df99d9d6F69fbe2722920883609532EFc2541d;

  function execute() external {
    AaveV3Optimism.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3Optimism.ACL_MANAGER.removeRiskAdmin(AaveV3Optimism.RISK_STEWARD);
  }
}
