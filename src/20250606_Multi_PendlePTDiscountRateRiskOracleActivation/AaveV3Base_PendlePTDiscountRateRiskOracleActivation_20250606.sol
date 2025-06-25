// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';

import {IRiskSteward} from './interfaces/IRiskSteward.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3Base_PendlePTDiscountRateRiskOracleActivation_20250606 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x085E34722e04567Df9E6d2c32e82fd74f3342e79;

  function execute() external {
    AaveV3Base.ACL_MANAGER.removeRiskAdmin(AaveV3Base.RISK_STEWARD);
    AaveV3Base.ACL_MANAGER.removeRiskAdmin(AaveV3Base.CAPS_PLUS_RISK_STEWARD);
    AaveV3Base.ACL_MANAGER.removeRiskAdmin(AaveV3Base.FREEZING_STEWARD);

    AaveV3Base.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    IRiskSteward(NEW_RISK_STEWARD).setAddressRestricted(AaveV3BaseAssets.GHO_UNDERLYING, true);
  }
}
