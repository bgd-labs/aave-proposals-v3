// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3Optimism_PendlePTDiscountRateRiskOracleActivation_20250606 is
  IProposalGenericExecutor
{
  address public constant NEW_RISK_STEWARD = 0xa59262276dB8F997948fdc4a10cBc1448A375636;

  function execute() external {
    AaveV3Optimism.ACL_MANAGER.removeRiskAdmin(AaveV3Optimism.RISK_STEWARD);
    AaveV3Optimism.ACL_MANAGER.removeRiskAdmin(AaveV3Optimism.CAPS_PLUS_RISK_STEWARD);
    AaveV3Optimism.ACL_MANAGER.removeRiskAdmin(AaveV3Optimism.FREEZING_STEWARD);

    AaveV3Optimism.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
