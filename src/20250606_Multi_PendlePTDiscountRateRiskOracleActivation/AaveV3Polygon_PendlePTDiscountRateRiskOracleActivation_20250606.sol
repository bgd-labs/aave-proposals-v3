// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606 is
  IProposalGenericExecutor
{
  address public constant NEW_RISK_STEWARD = 0x1e0A5985D58B45C38598e293189aa5228054629b;

  function execute() external {
    AaveV3Polygon.ACL_MANAGER.removeRiskAdmin(AaveV3Polygon.RISK_STEWARD);
    AaveV3Polygon.ACL_MANAGER.removeRiskAdmin(AaveV3Polygon.CAPS_PLUS_RISK_STEWARD);
    AaveV3Polygon.ACL_MANAGER.removeRiskAdmin(AaveV3Polygon.FREEZING_STEWARD);

    AaveV3Polygon.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
