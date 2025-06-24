// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606 is
  IProposalGenericExecutor
{
  address public constant NEW_RISK_STEWARD = 0x0451f67bA61966C346daBAbB50a30Cc6A9A67C69;

  function execute() external {
    AaveV3Scroll.ACL_MANAGER.removeRiskAdmin(AaveV3Scroll.RISK_STEWARD);
    AaveV3Scroll.ACL_MANAGER.removeRiskAdmin(AaveV3Scroll.CAPS_PLUS_RISK_STEWARD);
    AaveV3Scroll.ACL_MANAGER.removeRiskAdmin(AaveV3Scroll.FREEZING_STEWARD);

    AaveV3Scroll.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
