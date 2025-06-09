// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';

/**
 * @title Pendle PT Discount Rate Risk Oracle Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: http://governance.aave.com/t/chaos-labs-risk-oracles/17216
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
